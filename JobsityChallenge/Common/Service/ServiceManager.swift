//
//  ServiceManager.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Alamofire

class ServiceManager: NSObject {

    var dataRequest: DataRequest!

    public func executeRequest(url: String, paramaters: [String: AnyObject], responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let headers = [
            "Content-Type": "application/json;charset=utf-8",
            "Accept": "application/json",
        ]

        if let finalURL = URL(string: "\(ConfigManager.sharedInstance.baseURL)\(url)") {
            self.executeRequest(method: .get, url: finalURL, paramaters: paramaters, headers: headers, responseHandler: responseHandler, errorHandler: errorHandler)
        }
    }

    public func requestImage(url: String, responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        if let finalURL = URL(string: url) {
            self.dataRequest = Alamofire.request(finalURL).response(completionHandler: { (response) in
                if let _ = response.error {
                    errorHandler(response.error)
                    return
                }

                if let responseValue = response.data {
                    if response.response?.statusCode != 200 {
                        responseHandler(responseValue)
                        return
                    }
                    if response.error != nil {
                        errorHandler(response.error)
                    } else {
                        responseHandler(responseValue)
                    }
                    
                    return
                }

                errorHandler(nil)
            })
        }
    }

    private func executeRequest(method: Alamofire.HTTPMethod, url: URL, paramaters: [String: AnyObject]?, headers: [String: String], responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.dataRequest = Alamofire.request(url, method: method, parameters: paramaters, encoding: URLEncoding.default, headers: headers).response(completionHandler: { (response) in

            if let _ = response.error {
                errorHandler(response.error)
                return
            }

            if let responseValue = response.data {
                if response.response?.statusCode != 200 {
                    responseHandler(responseValue)
                    return
                }
                if response.error != nil {
                    errorHandler(response.error)
                } else {
                    responseHandler(responseValue)
                }
                
                return
            }

            errorHandler(nil)
        })
    }

    public func cancelRequest() {
        dataRequest.cancel()
    }
}
