//
//  MockNetworkServise.swift
//  newProjectTests
//
//  Created by Maksim Kasyanenko on 03.01.2023.
//

import Foundation
@testable import newProject

class MockNetworkServise: NetworkServiceProtocol {
    func getSearch(qwery: String) async throws -> [newProject.Track]? {
        return Track(artistName: "Test", trackName: "Test", collectionCensoredName: "Test", artworkUrl60: "URL", )
    }
    
    func load(url: String) async throws -> Data {
        <#code#>
    }
    
    
}
