
//
//  LocationServiceProtocol.swift
//  ListOfPeople
//
//

import CoreLocation
import Combine

protocol LocationServiceProtocol {
    var authorizationStatus: PassthroughSubject<CLAuthorizationStatus, Never> { get }
    
    func checkAuthorizationStatus() -> CLAuthorizationStatus
    func requestAuthorization()
    func fetchCurrentLocation() async throws -> CLLocation
}
