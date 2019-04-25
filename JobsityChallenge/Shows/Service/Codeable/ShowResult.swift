//
//  ShowResult.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ShowResult: Codable {

    var id: Int
    var url: String
    var name: String
    var type: String
    var language: String
    var genres: [String]
    var rating: ShowRaiting
    var image: ShowImage?
}

struct ShowRaiting: Codable{
    var average: Double?
}

struct ShowImage: Codable {
    var medium: String
    var original: String
}
