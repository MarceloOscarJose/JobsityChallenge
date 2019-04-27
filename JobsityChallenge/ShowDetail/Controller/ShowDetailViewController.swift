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

    @IBOutlet weak var segmentedMenu: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UITableView!

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
        segmentedMenu.layer.borderWidth = 2
        segmentedMenu.layer.borderColor = UIColor.black.cgColor
    }

    func updateShow(showId: Int) {

        resetShow()

        model.getShowDetail(showId: showId, responseHandler: { (detail) in
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
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        firstView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        secondView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
    }
}
