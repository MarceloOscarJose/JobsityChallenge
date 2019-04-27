//
//  String.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 26/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

extension String {

    func replaceHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: NSString.CompareOptions.regularExpression, range: nil)
    }
}
