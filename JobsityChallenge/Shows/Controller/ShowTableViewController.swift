//
//  ShowTableViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowTableViewController: UITableViewController {

    let model = ShowModel()
    let cellIdentifier = "ShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getShowList()
        self.setupControls()
    }

    func getShowList() {
        model.getShowList(nextPage: false, responseHandler: { (result) in
            self.tableView.reloadData()
        }) { (error) in
            print("Error")
        }
    }

    func setupControls() {
        splitViewController?.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK - Table delegate and Data source
extension ShowTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.shows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
        let showData = model.shows[indexPath.item]
        cell.setupCell(image: showData.image, title: showData.title, genres: showData.genres, raiting: showData.raiting)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ShowTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
