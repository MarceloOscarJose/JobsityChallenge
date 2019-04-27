//
//  EpisodeTableViewCell.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 27/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        episodeImage.layer.cornerRadius = 7
    }

    func updateCell(image: String?, name: String, season: Int, number: Int, airDate: String, airTime: String, summary: String?) {
        if let image = image {
            self.episodeImage.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "no-image"))
        }
        if let summary = summary {
            self.summaryLabel.text = summary.replaceHTMLTags()
        }

        nameLabel.text = name
        infoLabel.text = "Season: \(season) Ep: \(number)"
        dateLabel.text = "\(airDate) at \(airTime)"
    }
}
