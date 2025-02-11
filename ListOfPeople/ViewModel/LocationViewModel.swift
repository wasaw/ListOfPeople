
//
//  LocationViewModel.swift
//  ListOfPeople
//
//

import SwiftUI
import CoreLocation
import Combine

@MainActor
class LocationViewModel: ObservableObject {
//    MARK: - Properties
    @Published var location: CLLocationCoordinate2D?
    private let locationService: LocationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
//    MARK: Lifecycle
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
        
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

// MARK: - Private API

private extension LocationViewModel {
    func handleAuthorizationStatus(_ status: CLAuthorizationStatus) async {
         switch status {
         case .notDetermined:
             locationService.requestAuthorization()
         case .authorizedWhenInUse, .authorizedAlways:
             do {
                 let loc = try await locationService.fetchCurrentLocation()
                 location = loc.coordinate
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

// MARK: - Public API

extension LocationViewModel {
    func fetchLocation() async {
////        let status = locationService.checkAuthorizationStatus()
////        await handleAuthorizationStatus(status)
//        let status = locationService.checkAuthorizationStatus()
//        if status == .notDetermined {
//            locationService.requestAuthorization()
//        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
//            Task {
////                await handleAuthorizationStatus(status)
//            }
//        } else {
//            print("DEBUG: Доступ запрещен")
//        }
    }
}
