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
    var imageFrame: CGRect = .zero

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetControls()
    }

    func setupControls() {
        scrollView.delegate = self

        segmentedMenu.layer.borderWidth = 2
        segmentedMenu.layer.borderColor = UIColor.black.cgColor

        secondView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        secondView.estimatedRowHeight = 100
        secondView.rowHeight = UITableView.automaticDimension
        secondView.delegate = self
        secondView.dataSource = self

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(showFullImage))
        imageTap.cancelsTouchesInView = false
        imageTap.numberOfTapsRequired = 1
        showImage.isUserInteractionEnabled = true
        showImage.addGestureRecognizer(imageTap)
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

            self.imageFrame = self.showImage.frame
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

    func hideControls() {
        showImage.frame = self.scrollView.bounds
        showImage.contentMode = .scaleAspectFill
        firstView.alpha = 0
        secondView.alpha = 0
        segmentedMenu.alpha = 0
    }

    func resetControls() {
        showImage.frame = self.imageFrame
        showImage.contentMode = .scaleAspectFill
        segmentedMenu.alpha = 1
        selectOption(segmentedMenu)
    }

    @objc func showFullImage(_ sender: UITapGestureRecognizer) {
        if firstView.alpha != 0 || secondView.alpha != 0 {
            scrollView.isScrollEnabled = false
            hideControls()
        } else {
            scrollView.isScrollEnabled = true
            resetControls()
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        firstView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        secondView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
        self.view.layoutSubviews()
    }
}

// MARK - Table delegate
extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.showDetail != nil ? self.showDetail.empisodes.count : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showDetail != nil ? self.showDetail.empisodes[section]?.count ?? 0 : 0
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

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}
