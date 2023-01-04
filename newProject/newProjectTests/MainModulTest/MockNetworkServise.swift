//
//  MockNetworkServise.swift
//  newProjectTests
//
//  Created by Maksim Kasyanenko on 03.01.2023.
//

import Foundation
@testable import newProject
protocol MockNetworkServiseProtocol: NetworkServiceProtocol {
    var mockData: Data { get }
    var mockSearch: String { get }
    var mockTrackComplite: [Track] { get }
    var mockTrackFailure: [Track]{ get }
    
}

class MockNetworkServise: MockNetworkServiseProtocol {
    let mockData: Data
    let mockSearch = "Test+Test"
    let mockTrackComplite = [Track(artistName: "Test", trackName: "Test", collectionCensoredName: "Test", artworkUrl60: "URL", previewUrl: "URL Test")]
    let mockTrackFailure = [Track(artistName: "Failure")]
    
    func getSearch(qwery: String) async throws -> [Track]? {
        guard qwery == mockSearch else { return mockTrackFailure }
        return mockTrackComplite
    }
    
    func load(url: String) async throws -> Data {
        return self.mockData
    }
    init(data: Data) {
        mockData = data
    }
    
}
