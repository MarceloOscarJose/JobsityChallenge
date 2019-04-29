//
//  ConfigManager.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ConfigManager: NSObject {

    static let sharedInstance = ConfigManager()

    // Config vars
    var baseURL = ""
    var touchIdProperty = "userlogin"

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let nsDictionary: NSDictionary = NSDictionary(contentsOfFile: path) {
                self.baseURL = nsDictionary["BaseURL"] as! String
            }
        }
    }
}
