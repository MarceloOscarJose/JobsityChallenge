//
//  FavoriteTableViewCell.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(image: String?, title: String, genres: String, rating: String) {
        self.titleLabel.text = title
        self.genresLabel.text = genres
        self.ratingLabel.text = rating

        if let image = image {
            self.showImage.af_cancelImageRequest()
            self.showImage.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "no-image"))
        } else {
            self.showImage.image = UIImage(named: "no-image")
        }
    }
}
