//
//  String+Extension.swift
//  TelepathyCompany
//
//  Created by james on 3/16/25.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
