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
    var shows: [ShowData] = []

    func getShowList(nextPage: Bool, responseHandler: @escaping (_ response: [ShowData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.currentPage += nextPage ? 1 : 0

        service.fetchShowList(page: currentPage, responseHandler: { (result) in
            for show in result {
                self.shows.append(ShowData(image: show.image.medium, title: show.name, genres: show.genres, raiting: show.rating.average))
            }
            responseHandler(self.shows)
        }) { (error) in
            errorHandler(error)
        }
    }
}
