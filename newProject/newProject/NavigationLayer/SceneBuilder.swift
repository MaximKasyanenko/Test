//
//  a.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//
import UIKit
import Foundation

protocol SceneBuilderProtocol {
    func createMainScene(router: RouterProtocol) -> UIViewController
    func createDetailsScene(track: Track, image: UIImage?, router: RouterProtocol) -> UIViewController
    
}

class SceneBuilder: SceneBuilderProtocol {
        
    func createMainScene(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let network = NetworkService()
        let trackServise = TrackService(network: network)
        let presenter = MainPresenter(view: view, router: router, trackServise: trackServise)
        view.presenter = presenter
        return view
    }
    
    func createDetailsScene(track: Track, image: UIImage?, router: RouterProtocol) -> UIViewController {
        let view = DetailView()
        let download = DownloadTrack(urlTrack: track.previewUrl)
        let presenter = DetailsPresenter(view: view, track: track, router: router, download: download, image: image)
        view.presenter = presenter
        download.delegete = presenter
        return view
    }
}
