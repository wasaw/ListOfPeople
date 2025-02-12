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
//            users = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
            users = [User(avatar: "https://avatar.iran.liara.run/public", name: "Wasaw", latitude: 30.42, longitude: 31.28),
                     User(avatar: "https://avatar.iran.liara.run/public", name: "Saws", latitude: 21.17, longitude: 29.04),
                     User(avatar: "https://avatar.iran.liara.run/public", name: "Dsasda", latitude: 21.00, longitude: 49.11)]
            referencePoint = try await locationService.fetchCurrentLocation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchDistance(user: User) -> CLLocationDistance {
        let location = CLLocation(latitude: user.latitude, longitude: user.longitude)
        return referencePoint.distance(from: location)
    }
    
    func setReferencePoint(pinnedUser: User) {
        if let index = users.firstIndex(where: { $0.id == pinnedUser.id }) {
            users.remove(at: index)
        }
        referencePoint = CLLocation(latitude: pinnedUser.latitude, longitude: pinnedUser.longitude)
    }
    
    func setGPSRefencePoint(pinnedUser: User) async {
        users.append(pinnedUser)
        do {
            referencePoint = try await locationService.fetchCurrentLocation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addUser(_ user: User) {
        users.append(user)
    }
}
