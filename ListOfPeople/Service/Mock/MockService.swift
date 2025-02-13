//
//  MockService.swift
//  ListOfPeople
//
//

import Foundation

final class MockService: NetworkServiceProtocol {
//    MARK: Properties
    let jsonString = "[{\"avatar\":\"https://avatar.iran.liara.run/public/48\",\"name\":\"Wasaw\",\"latitude\":32.22,\"longitude\": 31.28},{\"avatar\":\"https://avatar.iran.liara.run/public/39\",\"name\":\"Saws\",\"latitude\":21.17,\"longitude\": 29.04},{\"avatar\":\"https://avatar.iran.liara.run/public/96\",\"name\":\"Jhoel\",\"latitude\":32.17,\"longitude\": 40.21},{\"avatar\":\"https://avatar.iran.liara.run/public/17\",\"name\":\"Leon\",\"latitude\":18.17,\"longitude\": 22.21},{\"avatar\":\"https://avatar.iran.liara.run/public/45\",\"name\":\"El\",\"latitude\":64.23,\"longitude\": 90.54},{\"avatar\":\"https://avatar.iran.liara.run/public/22\",\"name\":\"Evi\",\"latitude\":16.57,\"longitude\": 46.23},{\"avatar\":\"https://avatar.iran.liara.run/public/94\",\"name\":\"Key\",\"latitude\":64.39,\"longitude\": 32.83},{\"avatar\":\"https://avatar.iran.liara.run/public/92\",\"name\":\"Mikle\",\"latitude\":37.23,\"longitude\": 73.23},{\"avatar\":\"https://avatar.iran.liara.run/public/34\",\"name\":\"July\",\"latitude\":26.85,\"longitude\": 57.75},{\"avatar\":\"https://avatar.iran.liara.run/public/18\",\"name\":\"Kai\",\"latitude\":20.74,\"longitude\": 82.93},{\"avatar\":\"https://avatar.iran.liara.run/public/44\",\"name\":\"Bob\",\"latitude\":55.57,\"longitude\": 22.23},{\"avatar\":\"https://avatar.iran.liara.run/public/55\",\"name\":\"Ron\",\"latitude\":55.66,\"longitude\": 44.97}]"
}

// MARK: - Public API
extension MockService {
    func fetchUserData<T>(from urlString: String) async throws -> T where T : Decodable {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw URLError(.badURL)
        }

        return try JSONDecoder().decode(T.self, from: jsonData)
    }
}
