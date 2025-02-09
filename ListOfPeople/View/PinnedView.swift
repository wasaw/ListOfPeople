//
//  PinnedView.swift
//  ListOfPeople
//
//

import SwiftUI

struct PinnedView: View {
    let user: UserViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.avatar)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(user.name)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Text(String(user.distance))
                    .foregroundStyle(.white)
            }
            Spacer()
        }
        .border(.red, width: 1)
        .background(.gray)
        .padding(15)
    }
}
