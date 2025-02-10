//
//  UserViewModel.swift
//  ListOfPeople
//
//

import SwiftUI

struct UserViewModel: Identifiable, Decodable {
//    MARK: - Properties
    let id = UUID()
//    let avatar: String
    let name: String
//    let distance: Double
    let latitude: String
    let longitude: String
}
