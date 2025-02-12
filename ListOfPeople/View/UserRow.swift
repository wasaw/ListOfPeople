//
//  UserRow.swift
//  ListOfPeople
//
//

import SwiftUI

struct UserRow: View {
//    MARK: - Properties
    let user: User
    let distance: Double
    
//    MARK: - Core
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: user.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 55, height: 55)
                VStack(alignment: .leading) {
                    Text("\(distance, specifier: "%.2f")")
                        .font(.headline)
                    Text(user.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}
