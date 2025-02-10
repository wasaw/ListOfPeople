//
//  NetworkService.swift
//  ListOfPeople
//
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
}

// MARK: - Public API

extension NetworkService {
    func fetchUserData<T: Decodable>(from urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        return try JSONDecoder().decode(T.self, from: try Data(contentsOf: url))
    }
}
