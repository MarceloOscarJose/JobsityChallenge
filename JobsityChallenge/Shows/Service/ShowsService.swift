//
//  ShowsService.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ShowsService: ServiceManager  {
    let upcommingURL = "shows"

    func fetchShowList(page: Int, responseHandler: @escaping (_ response: [ShowResult]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: String] = ["page": "\(page)"]

        self.executeRequest(url: self.upcommingURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let movieResult = try JSONDecoder().decode([ShowResult].self, from: data)
                responseHandler(movieResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
