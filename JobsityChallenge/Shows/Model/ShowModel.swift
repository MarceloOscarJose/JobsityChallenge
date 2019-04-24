//
//  ShowModel.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowModel: NSObject {

    let service = ShowsService()
    var currentPage: Int = 0
    var shows: [ShowResult] = []

    func getShowList(nextPage: Bool, responseHandler: @escaping (_ response: [ShowResult]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.currentPage += nextPage ? 1 : 0

        service.fetchShowList(page: currentPage, responseHandler: { (result) in
            self.shows = result
            responseHandler(self.shows)
        }) { (error) in
            errorHandler(error)
        }
    }
}
