//
//  ShowDetailData.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct ShowDetailData {

    let serviceManager = ServiceManager()

    var image: String?
    var title: String
    var genres: String
    var raiting: String

    public init(image: String?, title: String, genres: [String]?, raiting: Double?) {
        self.image = image
        self.title = title

        if let genres = genres, genres.count > 0 {
            self.genres = genres.joined(separator: "/")
        } else {
            self.genres = "No genres"
        }
        if let raiting = raiting {
            self.raiting = "\(raiting)"
        } else {
            self.raiting = "No raiting"
        }
    }

    func fetchImage(url: String, responseHandler: @escaping (_ response: UIImage?) -> Void) {
        serviceManager.requestImage(url: url, responseHandler: { (data) in
            responseHandler(UIImage(data: data))
        }) { (_) in
            responseHandler(UIImage(named: "no-image"))
        }
    }

    func cancelFetch() {
        serviceManager.cancelRequest()
    }
}
