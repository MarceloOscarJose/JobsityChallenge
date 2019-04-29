//
//  MainModel.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainModel: NSObject {

    func loginWithTouchId(responseHandler: @escaping (_ response: Bool) -> Void) {

        let myContext = LAContext()
        let myLocalizedReasonString = "Login with touch id"

        var authError: NSError?
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                DispatchQueue.main.async {
                    if success {
                        responseHandler(true)
                    } else {
                        responseHandler(false)
                    }
                }
            }
        } else {
            responseHandler(false)
        }
    }
}
