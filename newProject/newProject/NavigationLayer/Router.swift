//
//  Router.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import UIKit
import AVKit

protocol RouterProtocol {
    func showMainScene()
    func showDetails(track: Track, image: UIImage?)
    func showPlayer(localUrl: URL?, view: UIViewController)
}

class Router: RouterProtocol {
    private var navigationController: UINavigationController
    private var sceneBuilder: SceneBuilderProtocol
    
    init(navigationController: UINavigationController, sceneBuilder: SceneBuilderProtocol) {
        self.navigationController = navigationController
        self.sceneBuilder = sceneBuilder
    }
    
    func showMainScene() {
        let mainController = sceneBuilder.createMainScene(router: self)
        navigationController.viewControllers = [mainController]
    }
    
    func showDetails(track: Track, image: UIImage?) {
        let view = sceneBuilder.createDetailsScene(track: track, image: image, router: self)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showPlayer(localUrl: URL?, view: UIViewController) {
        let playerViewController = AVPlayerViewController()
        view.present(playerViewController, animated: true, completion: nil)
        guard let url = localUrl else { return }
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }

}
