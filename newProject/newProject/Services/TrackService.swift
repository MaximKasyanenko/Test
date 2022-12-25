//
//  TrackService.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 19.12.2022.
//

import Foundation

typealias VoidHandler = () -> Void

final class TrackService {
    private let network: NetworkServiceProtocol = NetworkService()
    var trackUpdateHandler: VoidHandler?
    private(set) var tracks: [Track]? {
        didSet {
            trackUpdateHandler?()
        }
    }
    
    @MainActor func getTrack(serch: String)  {
        Task {
            do {
                self.tracks = try await self.network.getSearch(qwery: serch)
            } catch {
                print(error)
            }
        }
    }
    
    func getImage(url: String, complition: @MainActor @escaping (Data) -> ()) {
        Task {
            let data = try? await network.load(url: url)
            guard let data = data else { return }
            await complition(data)
        }
    }
    
    @MainActor func setTrack(track: Track, completion: @escaping (Track, Data) -> Void) {
        Task {
            guard let url = track.artworkUrl60 else { return }
            let data = try? await network.load(url: url)
            guard let data = data else { return }
            completion(track, data)
        }
    }
}
