//
//  NetworkServiceProtocol.swift
//  ListOfPeople
//
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchUserData<T: Decodable>(from urlString: String) async throws -> T
}
