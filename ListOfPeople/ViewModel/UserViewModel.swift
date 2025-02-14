//
//  UserViewModel.swift
//  ListOfPeople
//
//

import SwiftUI
import CoreLocation
import Combine

@MainActor
class UserViewModel: ObservableObject {
//    MARK: - Properties
    @Published var users: [User] = []
    @Published var referencePoint: CLLocation?
    private let networkService = NetworkService()
    private let mockService = MockService()
    private let locationService = LocationService()
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
//    MARK: - Lifecycle
    
    init() {
        locationService.authorizationStatus
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] status in
                Task {
                    await self?.handleAuthorizationStatus(status)
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - Public API

extension UserViewModel {
    func loadUsers() async {
        do {
            users = try await mockService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
//            users = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
            referencePoint = try await locationService.fetchCurrentLocation()
            startUpdatingLocation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchDistance(user: User) -> CLLocationDistance {
        let location = CLLocation(latitude: user.latitude, longitude: user.longitude)
        guard let referencePoint = referencePoint else { return location.distance(from: location) }
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

// MARK: - Private API

private extension UserViewModel {
    func startUpdatingLocation() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { _ in
            Task { @MainActor in
                self.updateUserLocation()
            }
        })
    }
    
    func updateUserLocation() {
        users.indices.forEach {users[$0].updateCoordanates()}
        users = users
    }
    
    func handleAuthorizationStatus(_ status: CLAuthorizationStatus) async {
         switch status {
         case .notDetermined:
             locationService.requestAuthorization()
         case .authorizedWhenInUse, .authorizedAlways:
             do {
                 referencePoint = try await locationService.fetchCurrentLocation()
             } catch {
                 print("DEBUG: \(error.localizedDescription)")
             }
         case .denied, .restricted:
             print("DEBUG: Доступ запрещен")
         @unknown default:
             print("DEBUG: Неизвестный статус")
         }
     }
}
