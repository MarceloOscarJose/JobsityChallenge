//
//  UIImageView.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 25/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension UIImageView {

    public func imageFromUrl(url: String) {
        let service = ServiceManager()
        service.requestImage(url: url, responseHandler: { (data) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }) { (_) in
            DispatchQueue.main.async {
                self.image = UIImage(named: "no-image")
            }
        }
    }
}
