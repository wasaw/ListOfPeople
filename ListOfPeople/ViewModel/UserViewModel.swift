//
//  UserViewModel.swift
//  ListOfPeople
//
//

import SwiftUI
import CoreLocation

@MainActor
class UserViewModel: ObservableObject {
//    MARK: - Properties
    @Published var users: [User] = []
    private var referencePoint: CLLocation = CLLocation(latitude: 0, longitude: 0)
    private let networkService = NetworkService()
    private let locationService = LocationService()
}

// MARK: - Public API

extension UserViewModel {
    func loadUsers() async {
        do {
            users = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
            referencePoint = try await locationService.fetchCurrentLocation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchDistance(user: User) -> CLLocationDistance {
        let location = CLLocation(latitude: user.latitude, longitude: user.longitude)
        return referencePoint.distance(from: location)
    }
    
    func setReferencePoint(pointedUser: User) {
        referencePoint = CLLocation(latitude: pointedUser.latitude, longitude: pointedUser.longitude)
    }
}
