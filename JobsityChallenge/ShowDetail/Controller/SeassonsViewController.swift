//
//  SeassonsViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class SeassonsViewController: UIViewController {

    let cellIdentifier = "EpisodeTableViewCell"
    var episodes: [Int: [Int: ShowDetailEpisodes]] = [:]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionIndexTrackingBackgroundColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setEpisodes(episodes: [Int: [Int: ShowDetailEpisodes]]) {
        self.episodes = episodes
        tableView.reloadData()
    }

    func reloadData() {
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EpisodeViewController:
            if let index = self.tableView.indexPathForSelectedRow, let episodeData = self.episodes[index.section]?[index.item] {
                viewController.updateEpisode(episode: episodeData)
            }
        default:
            break
        }
    }
}

// MARK - Table delegate
extension SeassonsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.episodes.count > 0 ? self.episodes.count : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count > 0 ? self.episodes[section]?.count ?? 0 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let episodeData = self.episodes[indexPath.section]?[indexPath.item] {
            cell.textLabel?.text = "\(episodeData.number). \(episodeData.name)"
            cell.textLabel?.textColor = UIColor.ligthBlue
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionText = self.episodes[section]?.first?.value.season.description ?? ""
        return sectionText != "" ? "Seasson: \(sectionText)" : nil
    }
}
