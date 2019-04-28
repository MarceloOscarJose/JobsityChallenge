//
//  ShowDetail.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 26/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ShowDetail: Codable {
    var id: Int
    var name: String
    var network: ShowDetailNetwork?
    var premiered: String?
    var schedule: ShowDetailSchedule
    var genres: [String]
    var status: String
    var rating: ShowDetailRaiting
    var image: ShowDetailImage?
    var summary: String
    var embedded: ShowDetailEmbedded

    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case network
        case premiered
        case schedule
        case genres
        case status
        case rating
        case image
        case summary
        case embedded = "_embedded"
    }
}

struct ShowDetailRaiting: Codable{
    var average: Double?
}

struct ShowDetailImage: Codable {
    var original: String
    var medium: String
}

struct ShowDetailNetwork: Codable {
    var name: String
}

struct ShowDetailSchedule: Codable {
    var time: String
    var days: [String]
}

struct ShowDetailEmbedded: Codable {
    var episodes: [ShowDetailEpisodes]?
}

struct ShowDetailEpisodes: Codable {
    var id: Int
    var name: String
    var season: Int
    var number: Int
    var airdate: String
    var airtime: String
    var image: ShowDetailImage?
    var summary: String?
}
