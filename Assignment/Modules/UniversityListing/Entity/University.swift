//
//  University.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import RealmSwift

struct University: Codable {
    let name: String
    let country: String
    let webPages: [String]
    let domains: [String]
    let stateProvince: String?
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case webPages = "web_pages"
        case domains
        case stateProvince = "state-province"
        case countryCode = "alpha_two_code"
    }
    
    // Add this initializer
    init(from realmObject: UniversityObject) {
        self.name = realmObject.name
        self.country = realmObject.country
        self.webPages = Array(realmObject.webPages)
        self.domains = Array(realmObject.domains)
        self.stateProvince = realmObject.stateProvince
        self.countryCode = realmObject.countryCode
    }
}

class UniversityObject: Object {
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var country: String = ""
    @Persisted var countryCode: String = ""
    @Persisted var webPages = List<String>()
    @Persisted var domains = List<String>()
    @Persisted var stateProvince: String = ""
    @Persisted var lastUpdated: Date = Date()
    
    convenience init(from university: University) {
        self.init()
        self.name = university.name
        self.country = university.country
        self.countryCode = university.countryCode
        self.webPages.append(objectsIn: university.webPages)
        self.domains.append(objectsIn: university.domains)
        self.stateProvince = university.stateProvince ?? ""
        self.lastUpdated = Date()
    }
}


/*
 {
     "name": "Mohamed bin Zayed University of Artificial Intelligence (MBZUAI)",
     "domains": [
       "mbzuai.ac.ae"
     ],
     "state-province": "Abu Dhabi",
     "country": "United Arab Emirates",
     "web_pages": [
       "https://mbzuai.ac.ae/"
     ],
     "alpha_two_code": "AE"
   },
 */
