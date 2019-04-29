//
//  SettingsViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var touchIdSwitch: UISwitch!
    let model = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkTouchIdStatus()
    }

    func checkTouchIdStatus() {
        if model.biometricType() != .none {
            touchIdSwitch.isEnabled = true
            touchIdSwitch.isOn = model.getTouchIdProperty()
        } else {
            touchIdSwitch.isEnabled = false
        }
    }

    @IBAction func changeTouchId(_ sender: Any) {
        model.changeTouchIdProperty(value: touchIdSwitch.isOn)
    }
}
