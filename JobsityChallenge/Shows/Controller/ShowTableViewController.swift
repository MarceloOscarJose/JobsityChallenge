//
//  ShowTableViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowTableViewController: UITableViewController {

    let cellIdentifier = "ShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitViewController?.delegate = self

        self.setupControls()
        let model = ShowModel()
        model.getShowList(nextPage: false, responseHandler: { (result) in
            print("Todo bien")
        }) { (error) in
            print("Error")
        }
    }

    func setupControls() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK - Table delegate and Data source
extension ShowTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
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
