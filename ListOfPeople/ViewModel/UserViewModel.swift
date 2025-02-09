//
//  UserViewModel.swift
//  ListOfPeople
//
//

import SwiftUI

struct UserViewModel: Identifiable {
    let id = UUID()
    let avatar: String
    let name: String
    let distance: Double
}
