//
//  EpisodeViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    var episode: ShowDetailEpisodes!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }

    func updateEpisode(episode: ShowDetailEpisodes) {
        self.episode = episode
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let image = episode.image?.original {
            self.episodeImage.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "no-image"))
        }
        if let summary = episode.summary {
            self.summaryLabel.text = summary.replaceHTMLTags()
        }

        episodeLabel.text = "Season: \(episode.season) Ep: \(episode.number)"
        nameLabel.text = episode.name
        dateLabel.text = "\(episode.airdate) at \(episode.airtime)"
    }
}

extension EpisodeViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}
