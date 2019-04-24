//
//  ShowTableViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.delegate = self

        let model = ShowModel()
        model.getShowList(nextPage: false, responseHandler: { (result) in
            print("Todo bien")
        }) { (error) in
            print("Error")
        }
    }
}

extension ShowTableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
