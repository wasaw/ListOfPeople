//
//  UserRow.swift
//  ListOfPeople
//
//

import SwiftUI

struct UserRow: View {
    
//    MARK: - Properties
    let user: UserViewModel
    
//    MARK: - Core
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.avatar)
                    .font(.headline)
                Text(user.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(String(user.distance))
            }
            Spacer()
        }
        .padding()
    }
}
