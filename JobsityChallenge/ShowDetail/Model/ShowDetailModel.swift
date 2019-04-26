//
//  ShowDetailModel.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ShowDetailModel: NSObject {

    let service = ShowDetailService()

    func getShowDetail(showId: Int, responseHandler: @escaping (_ response: ShowDetailData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        service.fetchShowDetail(showId: showId, responseHandler: { (result) in
            let show = ShowDetailData(image: result.image?.original, title: result.name, genres: result.genres, raiting: result.rating.average)
            responseHandler(show)
        }) { (error) in
            errorHandler(error)
        }
    }
}
