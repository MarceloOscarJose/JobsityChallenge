//
//  ShowData.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct ShowData {
    
    var id: Int
    var image: String?
    var title: String
    var genres: String
    var rating: String

    public init(showData: ShowResult) {
        self.id = showData.id
        self.image = showData.image?.medium
        self.title = showData.name

        if showData.genres.count > 0 {
            self.genres = showData.genres.joined(separator: "/")
        } else {
            self.genres = "No genres"
        }
        if let raiting = showData.rating.average {
            self.rating = "\(String(repeating: "⭐️", count: Int(raiting / 2))) \(raiting)"
        } else {
            self.rating = "No raiting"
        }
    }
}
