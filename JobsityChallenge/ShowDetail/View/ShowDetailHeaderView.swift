//
//  ShowDetailHeaderView.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowDetailHeaderView: UIView {

    lazy var headerImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.contentMode = .scaleAspectFill
        headerImage.clipsToBounds = true
        return headerImage
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupControls()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupControls() {
        self.addSubview(headerImage)
    }

    func setupConstraints() {
        headerImage.translatesAutoresizingMaskIntoConstraints = false

        let leftConstraint = NSLayoutConstraint(item: headerImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: headerImage, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: headerImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 1)
        let bottomConstraint = NSLayoutConstraint(item: headerImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 1)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

    func updateImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.headerImage.image = image
        }
    }
}
