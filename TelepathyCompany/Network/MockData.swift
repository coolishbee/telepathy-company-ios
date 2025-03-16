//
//  MockData.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import Foundation

enum MockData {
    static func companyListData() -> Data {
        let fileName = "mockCompanyData"
        return readJSONData(from: fileName)
    }
    
    static private func readJSONData(from name: String) -> Data {
        guard let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
              let data = NSData(contentsOf: filePath)
        else {
            return Data()
        }
        return data as Data
    }
}
