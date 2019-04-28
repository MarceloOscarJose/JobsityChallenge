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
    var seassonsViewController: SeassonsViewController!

    // UI vars
    var imageFrame: CGRect = .zero
    var imagePlaceHolder = UIImage(named: "no-image")
    var rightButtonTexts: [String] = ["Show poster", "Hide poster"]

    // Show detail elements
    @IBOutlet weak var segmentedMenu: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageFrame = self.showImage.frame
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetControls()
    }

    func setupControls() {
        scrollView.delegate = self
        segmentedMenu.layer.borderWidth = 2
        segmentedMenu.layer.borderColor = UIColor.lightGray.cgColor

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonTexts.first!, style: .plain, target: self, action: #selector(showFullScreenPoster))
    }

    func updateShow(showId: Int) {

        resetShow()
        model.getShowDetail(showId: showId, responseHandler: { (detail) in

            self.showDetail = detail
            self.seassonsViewController.setEpisodes(episodes: detail.episodes)

            if let image = detail.image, let imageURL = URL(string: image) {
                self.showImage.af_cancelImageRequest()

                self.showImage.af_setImage(withURL: imageURL, placeholderImage: self.imagePlaceHolder, imageTransition: .curlDown(0.5), completion: { (_) in
                    self.showImage.isUserInteractionEnabled = true
                })
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
            self.showImage.image = imagePlaceHolder
            self.showTitle.text = "-"
            self.ratingLabel.text = "-"
            self.airsOnLabel.text = "-"
            self.scheduledLabel.text = "-"
            self.premieredLabel.text = "-"
            self.genresLabel.text = "-"
            self.statusLabel.text = "-"
            self.showSummary.text = "-"

            scrollView.setContentOffset(.zero, animated: false)
            segmentedMenu.selectedSegmentIndex = 0
            self.firstView.alpha = 1
            self.secondView.alpha = 0
            self.showImage.isUserInteractionEnabled = false
        }
    }

    func hideControls() {
        showImage.frame = self.scrollView.bounds
        showImage.contentMode = .scaleAspectFill
        firstView.alpha = 0
        secondView.alpha = 0
        segmentedMenu.alpha = 0
        scrollView.isScrollEnabled = false
        self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.last!
    }

    func resetControls() {
        showImage.frame = self.imageFrame
        showImage.contentMode = .scaleAspectFill
        segmentedMenu.alpha = 1
        selectOption(segmentedMenu)
        scrollView.isScrollEnabled = true
        self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.first!
    }

    @objc func showFullScreenPoster(_ sender: Any) {
        if self.showImage.image != imagePlaceHolder {
            if firstView.alpha != 0 || secondView.alpha != 0 {
                hideControls()
            } else {
                resetControls()
            }
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        firstView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        secondView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
        self.view.layoutSubviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as SeassonsViewController:
            self.seassonsViewController = viewController
        default:
            break
        }
    }
}

extension ShowDetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}
