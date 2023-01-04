//
//  File.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import Foundation

// MARK: - NetworkServiseProtocol
protocol NetworkServiceProtocol {
    func getSearch(qwery: String) async throws -> [Track]?
    func load(url:String) async throws -> Data
}
// MARK: - NetworkServise
class NetworkService: NetworkServiceProtocol {
    private let url = "https://itunes.apple.com/search?term="
    private let decode = DecodeService()
    //MARK: - APIs
    enum APIs: String {
        case count25 = "&limit=25"
        case count5 = "&limit=5"
    }
    //MARK: - URLerror
    enum URLerror: Error {
        case quveriURLerror
        case responseError
    }
    // MARK: Loading search result
    func getSearch(qwery: String) async throws -> [Track]? {
        let url = URL(string: url + qwery + APIs.count25.rawValue)
        guard let url = url else { throw URLerror.quveriURLerror  }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else { throw URLerror.responseError }
        let dataresp =  self.decode.decodeData(data: data, model: SearchResponse.self)
        return dataresp?.results
    }
    // MARK: Loading preview image
    func load(url:String) async throws -> Data {
        guard let url = URL(string: url)  else { throw URLerror.quveriURLerror }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else { throw URLerror.responseError }
        return data
    }
}
