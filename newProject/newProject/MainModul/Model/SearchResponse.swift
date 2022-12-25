//
//  SearchResponse.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import Foundation
struct SearchResponse: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var artistName: String
    var trackName: String?
    var collectionCensoredName: String?
    var artworkUrl60: String?
    var previewUrl: String?
}
