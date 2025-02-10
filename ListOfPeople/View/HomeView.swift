//
//  HomeView.swift
//  ListOfPeople
//
//

import SwiftUI

struct HomeView: View {
    
//    MARK: - Properties
    @State private var pinnedUser: UserViewModel?
    @StateObject private var locationViewModel = LocationViewModel(locationService: LocationService())
    private let networkService = NetworkService()
    
    var users: UserViewModel?
    
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
                
                List(sampleUsers) { user in
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
            await fetchData()
        }
    }
    
    func fetchData() async {
        do {
            let users: [User] = try await networkService.fetchUserData(from: "https://listofpeople.free.beeceptor.com/list")
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView()
}

let sampleUsers = [UserViewModel(name: "wasaw", latitude: "21", longitude: "231")]
//let sampleUsers = [
//    UserViewModel(avatar: "person", name: "Wasaw", distance: 100),
//    UserViewModel(avatar: "person", name: "Strong", distance: 20),
//    UserViewModel(avatar: "person", name: "Klerk", distance: 1220),
//    UserViewModel(avatar: "person", name: "Weak", distance: 1420),
//    UserViewModel(avatar: "person", name: "Unn", distance: 20),
//    UserViewModel(avatar: "person", name: "Jeed", distance: 189),
//    UserViewModel(avatar: "person", name: "Oldd", distance: 3620),
//    UserViewModel(avatar: "person", name: "Jer", distance: 2898),
//    UserViewModel(avatar: "person", name: "Ksss", distance: 222),
//    UserViewModel(avatar: "person", name: "Yan", distance: 1230),
//    UserViewModel(avatar: "person", name: "Kevin", distance: 283),
//    UserViewModel(avatar: "person", name: "Oly", distance: 4222),
//    UserViewModel(avatar: "person", name: "Mixs", distance: 1222)
//
//]
