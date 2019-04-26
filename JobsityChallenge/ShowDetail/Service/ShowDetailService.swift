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

    func fetchShowDetail(showId: Int, responseHandler: @escaping (_ response: ShowResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let finalURL = "\(showsURL)/\(showId)"

        self.executeRequest(url: finalURL, paramaters: [:], responseHandler: { (data) in
            do {
                let movieResult = try JSONDecoder().decode(ShowResult.self, from: data)
                responseHandler(movieResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
