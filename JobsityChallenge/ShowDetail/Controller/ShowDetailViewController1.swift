//
//  ShowDetailViewController.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import PXStickyHeaderCollectionView

/*class ShowDetailViewController1: UIViewController {

    let model = ShowDetailModel()

    // UI vars
    let headerView = ShowDetailHeaderView()
    var containerView: PXStickyHeaderCollectionView!
    let cellTopPadding: CGFloat = 20.0
    let cellBottomPadding: CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
        self.setupConstraints()
    }

    func setupControls() {
        self.containerView = PXStickyHeaderCollectionView(initHeaderHeight: 200, minHeaderHeight: 70, headerView: headerView)
        self.view.addSubview(containerView)
        containerView.delegate = self
        containerView.dataSource = self
    }

    func setupConstraints() {
        self.view.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let leftConstraint = NSLayoutConstraint(item: self.containerView!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.containerView!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.containerView!, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.containerView!, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

    func updateShow(showId: Int) {
        model.getShowDetail(showId: showId, responseHandler: { (showData) in
            if let image = showData.image {
                showData.fetchImage(url: image) { (image) in
                    self.headerView.updateImage(image: image)
                }
            }
        }) { (error) in
            print("Error")
        }
    }
}

extension ShowDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellId, for: indexPath) as! MovieCollectionViewCell
        
        let movieData = self.moviesData[indexPath.item]
        cell.updateCellData(image: movieData.poster, title: movieData.title, releaseDate: movieData.releaseDate, overview: movieData.overview)
        */
        return UICollectionViewCell()
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width
        return CGSize(width: widthPerItem, height: 200)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellTopPadding, left: 0, bottom: self.cellBottomPadding, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}*/
