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

    lazy var tableRefreshControl: UIRefreshControl = {
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.tintColor = UIColor.ligthBlue
        tableRefreshControl.addTarget(self, action: #selector(getFavorites), for: .valueChanged)
        return tableRefreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupControls() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = tableRefreshControl
    }

    @objc func getFavorites() {
        favoritesModel.fetchFavorites()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesModel.favorites.count
    }
}
