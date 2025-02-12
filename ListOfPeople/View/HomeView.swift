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
                        Task{
                            await userViewModel.setGPSRefencePoint(pinnedUser: pinnedUser)
                            self.pinnedUser = nil
                        }
                    }) {
                        PinnedView(user: pinnedUser)
                            .transition(.move(edge: .top))
                    }
                    .border(.yellow, width: 1)
                    .background(.orange)
                    .cornerRadius(15)
                }
                List(userViewModel.users) { user in
                    Button(action: {
                        if let pinnedUser = pinnedUser {
                            userViewModel.addUser(pinnedUser)
                        }
                        self.pinnedUser = user
                        userViewModel.setReferencePoint(pinnedUser: user)
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
    
//    MARK: - Helpers
    
    func setGPSLocation(pinnedUser: User) async {
        await userViewModel.setGPSRefencePoint(pinnedUser: pinnedUser)
    }
}

#Preview {
    HomeView()
}
