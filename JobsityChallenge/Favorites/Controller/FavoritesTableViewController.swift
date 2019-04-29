//
//  FavoritesTableViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    let favoritesModel = FavoritesModel()
    let cellIdentifier = "FavoriteTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavorites()
    }

    func setupControls() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 100
    }

    @objc func getFavorites() {
        favoritesModel.fetchFavorites()
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)

        if let navigationController = self.navigationController {

            let detailScreen = UIStoryboard(name: "ShowDetail", bundle: .main)
            let detailViewController = detailScreen.instantiateInitialViewController() as! ShowDetailViewController

            let showData = favoritesModel.favorites[indexPath.item]
            detailViewController.updateShow(showId: Int(showData.id))
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesModel.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteTableViewCell

        let favoriteData = favoritesModel.favorites[indexPath.item]
        cell.setupCell(image: favoriteData.image, title: favoriteData.name!, genres: favoriteData.genres!, rating: favoriteData.rating!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteData = favoritesModel.favorites[indexPath.item]
            favoritesModel.deleteFavorite(showId: favoriteData.id)
            self.getFavorites()
        }
    }
}
