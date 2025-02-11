//
//  PinnedView.swift
//  ListOfPeople
//
//

import SwiftUI

struct PinnedView: View {
//    MARK: - Properties
    let user: User
    
//    MARK: - Core
    var body: some View {
        VStack {
            HStack() {
                AsyncImage(url: URL(string: user.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 55, height: 55)
                VStack(alignment: .leading) {
                    Text("\(user.latitude) \(user.longitude)")
                        .font(.headline)
                    Text(user.name)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
        }
        .border(.red, width: 1)
        .background(.gray)
        .padding(15)
    }
}
