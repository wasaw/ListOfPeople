
//
//  LocationService.swift
//  ListOfPeople
//
//

import CoreLocation
import Combine

final class LocationService: NSObject, CLLocationManagerDelegate {
//    MARK: - Properties
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation, Error>?
    let authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Never>()
    
//    MARK: - Lifecycle
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
//    MARK: - Helpers
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            continuation?.resume(returning: location)
            continuation = nil
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus.send(manager.authorizationStatus)
        locationManager.requestLocation()
    }
}

// MARK: - Public API

extension LocationService: LocationServiceProtocol {
    func checkAuthorizationStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    func requestAuthorization() {
        requestLocationPermission()
    }
    
    func fetchCurrentLocation() async throws -> CLLocation {
        return try await withCheckedThrowingContinuation { continuation in
            if let previousContinuation = self.continuation {
                previousContinuation.resume(throwing: LocationError.multipleRequests)
            }
            self.continuation = continuation
            locationManager.requestLocation()
        }
    }
}

// MARK: - Private API

private extension LocationService {
    func requestLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied , .restricted:
            print("DEBUG: Доступ пользователем запрешен")
        case .authorizedWhenInUse, .authorizedAlways:
            print("DEBUG: Геолокация уже разрешена")
        default:
            print("DEBUG: Неизвестный статус авторизации")
        }
    }
}
