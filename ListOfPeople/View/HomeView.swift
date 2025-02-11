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
    @StateObject private var locationViewModel = LocationViewModel(locationService: LocationService())
//    private let networkService = NetworkService()
        
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
                    }) {
                        UserRow(user: user)
                    }

                }
            }
            .navigationTitle("Users")
        }
        .task {
//            await locationViewModel.fetchLocation()
//            await fetchData()
            await userViewModel.loadUsers()
        }
    }
    
//    func fetchData() async {
//        do {
//            let users: [User] = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
//        } catch {
//            print("DEBUG: \(error.localizedDescription)")
//        }
//    }
}

#Preview {
    HomeView()
}
