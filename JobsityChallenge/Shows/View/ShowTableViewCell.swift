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
    @IBOutlet weak var generes: UILabel!
    @IBOutlet weak var raiting: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(image: String, title: String, generes: String, raiting: String) {
        
    }
}
