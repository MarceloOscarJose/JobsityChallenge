//
//  ShowTableViewCell.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var raiting: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.showImage.layer.cornerRadius = 7
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.image = nil
    }

    func setupCell(image: String?, title: String, genres: String, raiting: String) {
        self.title.text = title
        self.genres.text = genres
        self.raiting.text = raiting

        if let image = image {
            self.showImage.af_cancelImageRequest()
            self.showImage.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "no-image"))
        } else {
            self.showImage.image = UIImage(named: "no-image")
        }
    }
}
