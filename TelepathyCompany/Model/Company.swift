//
//  Company.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import Foundation

struct Company: Codable, Identifiable {
    var id: Int {
        return code.value
    }
    
    let code: AnyIntValue
    let name, addr, type, intro, welfare, img: String
    let lat, lng: AnyDoubleValue?
    let jobs: [Job]
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case addr
        case type
        case intro
        case welfare
        case img
        case lat, lng
        case jobs
    }
}

struct Job: Codable, Identifiable {
    let id: Int
    let title: String
    let detail: String
    let responsibilities: String
    let requirements: String
    let preferred: String
}


extension Company {
    var latitude: Double {
        return lat?.value ?? 0
    }
    
    var longitude: Double {
        return lng?.value ?? 0
    }
    
    
}
