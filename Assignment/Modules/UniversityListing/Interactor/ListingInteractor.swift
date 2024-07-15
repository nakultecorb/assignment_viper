//
//  ListingInteractor.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import RealmSwift

protocol ListingInteractorProtocol: AnyObject {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void)
}

class ListingInteractor: ListingInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheManager: CacheManager
    
    
    init(networkService: NetworkServiceProtocol, cacheManager: CacheManager = .shared) {
        self.networkService = networkService
        self.cacheManager = cacheManager
    }
    
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        networkService.fetchUniversities { [weak self] result in
            switch result {
            case .success(let universities):
                self?.cacheManager.saveUniversities(universities)
                completion(.success(universities))
            case .failure(let error):
                // Try to fetch from cache if API fails
                let cachedUniversities = self?.cacheManager.getUniversities() ?? []
                if !cachedUniversities.isEmpty {
                    completion(.success(cachedUniversities))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func fetchFromAPIAndCache(completion: @escaping (Result<[University], Error>) -> Void) {
        networkService.fetchUniversities { [weak self] result in
            switch result {
            case .success(let universities):
                self?.cacheManager.saveUniversities(universities)
                self?.cacheManager.updateCacheTimestamp()
                completion(.success(universities))
            case .failure:
                let cachedUniversities = self?.cacheManager.getUniversities() ?? []
                if !cachedUniversities.isEmpty {
                    completion(.success(cachedUniversities))
                } else {
                    completion(.failure(NSError(domain: "No data available", code: 0, userInfo: nil)))
                }
            }
        }
    }
}
