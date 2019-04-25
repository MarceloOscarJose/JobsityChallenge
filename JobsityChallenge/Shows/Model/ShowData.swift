//
//  ShowData.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct ShowData {
    var image: String
    var title: String
    var genres: String
    var raiting: String

    public init(image: String, title: String, genres: [String]?, raiting: Double?) {
        self.image = image
        self.title = title

        if let genres = genres {
            self.genres = genres.joined(separator: "/")
        } else {
            self.genres = ""
        }
        if let raiting = raiting {
            self.raiting = "⭐️ \(raiting)"
        } else {
            self.raiting = ""
        }
    }
}
