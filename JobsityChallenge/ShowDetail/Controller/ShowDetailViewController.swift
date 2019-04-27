//
//  ShowDetailViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 26/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class ShowDetailViewController: UIViewController {

    let model = ShowDetailModel()
    var showDetail: ShowDetailData!
    let cellIdentifier = "EpisodeTableViewCell"

    @IBOutlet weak var segmentedMenu: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Show detail elements
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var airsOnLabel: UILabel!
    @IBOutlet weak var scheduledLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var showSummary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        segmentedMenu.layer.borderWidth = 2
        segmentedMenu.layer.borderColor = UIColor.black.cgColor

        secondView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        secondView.estimatedRowHeight = 100
        secondView.rowHeight = UITableView.automaticDimension
        secondView.delegate = self
        secondView.dataSource = self
    }

    func updateShow(showId: Int) {

        resetShow()

        model.getShowDetail(showId: showId, responseHandler: { (detail) in

            self.showDetail = detail
            self.secondView.reloadData()

            if let image = detail.image {
                self.showImage.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "no-image"))
            }

            self.showTitle.text = detail.title
            self.ratingLabel.text = detail.rating
            self.airsOnLabel.text = detail.airsOn
            self.scheduledLabel.text = detail.scheduled
            self.premieredLabel.text = detail.premiered
            self.genresLabel.text = detail.genres
            self.statusLabel.text = detail.status
            self.showSummary.text = detail.summary.replaceHTMLTags()
            
        }) { (error) in
            print("Error")
        }
    }

    func resetShow() {
        if let _ = self.showImage {
            self.showImage.image = UIImage(named: "no-image")
            self.showTitle.text = "-"
            self.ratingLabel.text = "-"
            self.airsOnLabel.text = "-"
            self.scheduledLabel.text = "-"
            self.premieredLabel.text = "-"
            self.genresLabel.text = "-"
            self.statusLabel.text = "-"
            self.showSummary.text = "-"

            secondView.setContentOffset(.zero, animated: false)
            scrollView.setContentOffset(.zero, animated: false)
            segmentedMenu.selectedSegmentIndex = 0
            self.firstView.alpha = 1
            self.secondView.alpha = 0
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        firstView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        secondView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
        self.view.layoutSubviews()
    }
}

extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = self.showDetail != nil ? self.showDetail.empisodes.count : 0
        return sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.showDetail != nil ? self.showDetail.empisodes[section]?.count ?? 0 : 0
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EpisodeTableViewCell

        if let detail = self.showDetail {
            if let detailData = detail.empisodes[indexPath.section]?[indexPath.item] {
                cell.updateCell(image: detailData.image?.medium, name: detailData.name, season: detailData.season, number: detailData.number, airDate: detailData.airdate, airTime: detailData.airtime, summary: detailData.summary)
                }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionText = self.showDetail.empisodes[section]?.first?.value.season.description ?? ""
        return sectionText != "" ? "Seasson: \(sectionText)" : nil
    }

    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = EpisodeTableSectionView()
        sectionHeader.layoutIfNeeded()

        if let headerText = self.showDetail.empisodes[section]?.first?.value.season.description {
            sectionHeader.sectionLabel.text = "Seasson: \(headerText)"
        }

        return sectionHeader
    }*/
}
