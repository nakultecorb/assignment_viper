//
//  CacheManager.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import RealmSwift

class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    func saveUniversities(_ universities: [University]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(universities.map { UniversityObject(from: $0) }, update: .modified)
        }
    }
    
    func getUniversities() -> [University] {
        let realm = try! Realm()
        return realm.objects(UniversityObject.self).map { University(from: $0) }
    }
    
    func clearCache() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func shouldRefreshCache(olderThan minutes: Int = 30) -> Bool {
            let realm = try! Realm()
            guard let lastUpdated = realm.objects(UniversityObject.self).sorted(byKeyPath: "lastUpdated").last?.lastUpdated else {
                return true
            }
            return Date().timeIntervalSince(lastUpdated) > Double(minutes * 60)
        }
        
        func updateCacheTimestamp() {
            let realm = try! Realm()
            try! realm.write {
                realm.objects(UniversityObject.self).forEach { $0.lastUpdated = Date() }
            }
        }
}


