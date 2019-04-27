//
//  ShowDetailService.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowDetailService: ServiceManager {

    let showsURL = "shows"

    func fetchShowDetail(showId: Int, responseHandler: @escaping (_ response: ShowDetail) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let finalURL = "\(showsURL)/\(showId)"
        let parameters: [String: String] = ["embed": "episodes"]

        self.executeRequest(url: finalURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let movieResult = try JSONDecoder().decode(ShowDetail.self, from: data)
                responseHandler(movieResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
