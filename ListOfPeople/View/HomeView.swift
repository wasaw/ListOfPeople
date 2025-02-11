//
//  HomeView.swift
//  ListOfPeople
//
//

import SwiftUI

struct HomeView: View {
    
//    MARK: - Properties
    @State private var pinnedUser: User?
    @StateObject private var userViewModel = UserViewModel()
            
//    MARK: - Core
    var body: some View {
        NavigationView {
            VStack {
                if let pinnedUser = pinnedUser {
                    Button(action: {
                        self.pinnedUser = nil
                    }) {
                        PinnedView(user: pinnedUser)
                            .transition(.move(edge: .top))
                            .padding(.horizontal, 25)
                    }
                }
                List(userViewModel.users) { user in
                    Button(action: {
                        self.pinnedUser = user
                        userViewModel.setReferencePoint(pointedUser: user)
                    }) {
                        let distance = userViewModel.fetchDistance(user: user)
                        UserRow(user: user, distance: distance)
                    }

                }
            }
            .navigationTitle("Users")
        }
        .task {
            await userViewModel.loadUsers()
        }
    }
}

#Preview {
    HomeView()
}
