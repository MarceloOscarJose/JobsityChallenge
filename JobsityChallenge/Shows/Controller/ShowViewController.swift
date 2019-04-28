//
//  ShowViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    lazy var tableRefreshControl: UIRefreshControl = {
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.tintColor = UIColor.ligthBlue
        tableRefreshControl.addTarget(self, action: #selector(getShowList), for: .valueChanged)
        return tableRefreshControl
    }()

    lazy var tableButtonRefreshControl: UIActivityIndicatorView = {
        let tableButtonRefreshControl = UIActivityIndicatorView(style: .gray)
        tableButtonRefreshControl.color = UIColor.ligthBlue
        tableButtonRefreshControl.hidesWhenStopped = true
        tableButtonRefreshControl.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100)
        return tableButtonRefreshControl
    }()

    let model = ShowModel()
    let favoritesModel = FavoritesModel()

    let cellIdentifier = "ShowTableViewCell"
    var nextPage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
        self.getShowList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesModel.fetchFavorites()
        self.tableView.reloadData()
    }

    @objc func getShowList() {
        self.tableButtonRefreshControl.startAnimating()
        model.getShowList(nextPage: self.nextPage, responseHandler: { (result) in
            self.reloadTable()
        }) { (error) in
            print("Error")
        }
    }

    func seachShows(showName: String) {
        self.tableButtonRefreshControl.startAnimating()
        model.searchShows(showName: showName, responseHandler: { (result) in
            self.reloadTable()
        }) { (error) in
            print("Error")
        }
    }

    func reloadTable() {
        self.tableRefreshControl.endRefreshing()
        self.tableView.reloadData()
        self.tableButtonRefreshControl.stopAnimating()
    }

    func shouldUpdateShows(indexPath: IndexPath) {
        if model.shows.count > 1 {
            if indexPath.row == model.shows.count - 1 {
                self.nextPage = true
                self.getShowList()
            }
        }
    }

    func setupControls() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = tableRefreshControl
        tableView.tableFooterView = tableButtonRefreshControl
    }
}

// MARK - Table delegate and Data source
extension ShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell

        if model.shows.count > indexPath.item {
            let showData = model.shows[indexPath.item]
            let favorite = favoritesModel.favorites.map { $0.id == showData.id }.contains(true)

            cell.delegate = self
            cell.setupCell(showIndex: indexPath.item, image: showData.image, title: showData.title, genres: showData.genres, raiting: showData.rating, favorite: favorite)
        }

        shouldUpdateShows(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)

        if let navigationController = self.navigationController {

            let detailScreen = UIStoryboard(name: "ShowDetail", bundle: .main)
            let detailViewController = detailScreen.instantiateInitialViewController() as! ShowDetailViewController

            let showData = model.shows[indexPath.item]
            detailViewController.updateShow(showId: showData.id)
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}

// MARK - Search bar delegate
extension ShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        self.model.currentPage = 0
        self.nextPage = false

        if let text = searchBar.text, text.count >= 2 {
            self.seachShows(showName: text)
            searchBar.endEditing(true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Insert at least 2 characters to search", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            searchBar.endEditing(true)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        self.nextPage = false
        self.model.currentPage = 0
        self.getShowList()
    }
}

extension ShowViewController: ShowTableViewCellProtocol {

    func addToFavorites(showIndex: Int) {
        favoritesModel.saveFavorite(showData: model.shows[showIndex])
        favoritesModel.fetchFavorites()
    }
}
