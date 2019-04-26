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
    let cellIdentifier = "ShowTableViewCell"
    let detailViewController = ShowDetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
        self.getShowList()
    }

    @objc func getShowList(nextPage: Bool = false) {
        self.tableButtonRefreshControl.startAnimating()
        model.getShowList(nextPage: nextPage, responseHandler: { (result) in
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
        if indexPath.row == model.shows.count - 1 {
            self.getShowList(nextPage: true)
        }
    }

    func setupControls() {
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible
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
            cell.setupCell(title: showData.title, genres: showData.genres, raiting: showData.raiting)

            if let image = showData.image, cell.showImage.image == nil {
                showData.fetchImage(url: image) { (image) in
                    cell.updateImage(image: image)
                }
            } else {
                cell.updateImage(image: UIImage(named: "no-image"))
            }
        }

        shouldUpdateShows(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)

        if let splitController = splitViewController {
            let showData = model.shows[indexPath.item]
            detailViewController.updateShow(showId: showData.id)
            splitController.showDetailViewController(detailViewController, sender: nil)
        }
    }
}

// MARK - Search bar delegate
extension ShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.seachShows(showName: text)
            searchBar.endEditing(true)
        }
    }
}

extension ShowViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
