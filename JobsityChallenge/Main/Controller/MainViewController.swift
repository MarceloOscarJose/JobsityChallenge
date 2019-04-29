//
//  MainViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    let model = MainModel()
    let touchIdKey = ConfigManager.sharedInstance.loginProperty

    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkTouchIdLogin()
    }

    @IBAction func tryAgainLogin(_ sender: Any) {
        checkTouchIdLogin()
    }

    func checkTouchIdLogin() {
        let touchId: Bool = UserDefaults.standard.bool(forKey: touchIdKey)

        if touchId {
            self.containerView.alpha = 1
            model.loginWithTouchId { (result) in
                if result {
                    self.performSegue(withIdentifier: "MainSegue", sender: nil)
                }
            }
        }
        else {
            self.performSegue(withIdentifier: "MainSegue", sender: nil)
        }
    }
}
