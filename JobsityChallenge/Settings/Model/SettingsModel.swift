//
//  SettingsModel.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsModel: NSObject {

    let touchIdKey = ConfigManager.sharedInstance.touchIdProperty

    func changeTouchIdProperty(value: Bool) {
        UserDefaults.standard.set(value, forKey: touchIdKey)
    }

    func getTouchIdProperty() -> Bool {
        let touchId: Bool = UserDefaults.standard.bool(forKey: touchIdKey)
        return touchId
    }

    func biometricType() -> BiometricType {
        let authContext = LAContext()

        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            @unknown default:
                return .none
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }

    enum BiometricType {
        case none
        case touch
        case face
    }
}
