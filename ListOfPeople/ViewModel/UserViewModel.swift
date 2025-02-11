//
//  UserViewModel.swift
//  ListOfPeople
//
//

import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
//    MARK: - Properties
    @Published var users: [User] = []
    private let networkService = NetworkService()
    
    func loadUsers() async {
        do {
            users = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
        } catch {
            print(error.localizedDescription)
        }
    }
}
