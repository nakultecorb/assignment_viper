//
//  NetworkService.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        let urlString = "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.serverError("Invalid URL")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(NetworkError.networkUnavailable))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let universities = try JSONDecoder().decode([University].self, from: data)
                    completion(.success(universities))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
    case serverError(String)
    case networkUnavailable
    
    var message: String {
        switch self {
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Unable to process the data from the server."
        case .serverError(let message):
            return "Server error: \(message)"
        case .networkUnavailable:
            return "Network is unavailable. Please check your internet connection."
        }
    }
}
