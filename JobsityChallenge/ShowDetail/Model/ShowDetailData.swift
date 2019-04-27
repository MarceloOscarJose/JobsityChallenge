//
//  ShowDetailData.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct ShowDetailData {

    var id: Int
    var title: String
    var airsOn: String
    var premiered: String
    var scheduled: String
    var genres: String
    var status: String
    var rating: String
    var image: String?
    var summary: String
    var empisodes: [Int: [ShowDetailEpisodes]] = [:]

    public init(showDetail: ShowDetail) {
        self.id = showDetail.id
        self.title = showDetail.name
        self.airsOn = showDetail.network.name
        self.scheduled = "\(showDetail.schedule.days.joined()) at \(showDetail.schedule.time)"
        self.premiered = showDetail.premiered
        self.status = showDetail.status
        self.image = showDetail.image?.original
        self.summary = showDetail.summary

        if showDetail.genres.count > 0 {
            self.genres = showDetail.genres.joined(separator: "/")
        } else {
            self.genres = "No genres"
        }
        if let rating = showDetail.rating.average {
            self.rating = "\(rating)"
        } else {
            self.rating = "No raiting"
        }

        if var episodes = showDetail.embedded.episodes {
            episodes.sort(by: { Int($1.season) > Int($0.season) })
            for episode in episodes {
                let season = Int(episode.season)
                if var value = self.empisodes[season] {
                    value.append(episode)
                    self.empisodes.updateValue(value, forKey: season)
                } else {
                    self.empisodes.updateValue([episode], forKey: season)
                }
            }
        }
    }
}
