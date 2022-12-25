//
//  DetailPresentor.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 07.12.2022.
//

import UIKit

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol: AnyObject {
    var downloadTrack: DownloadProtocol? { get set }
    init(view: DetailViewProtocol?, track: Track, router: RouterProtocol, download: DownloadProtocol, image: UIImage?)
    func downLoadTrack()
}
// MARK: - DetailPresentor
final class DetailsPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var track: Track
    var router: RouterProtocol?
    var downloadTrack: DownloadProtocol?
    
    required init(view: DetailViewProtocol?, track: Track, router: RouterProtocol, download: DownloadProtocol, image: UIImage?) {
        self.view = view
        self.track = track
        self.router = router
        self.downloadTrack = download
        view?.setController(track: track, image: image)
    }
    
    func downLoadTrack() {
        self.presentPlayer()
    }
}
//MARK: - Private func
private extension DetailsPresenter {
    func presentPlayer() {
        guard let controller = view as? UIViewController else { return }
        if let url = downloadTrack?.localUrlTrack {
            router?.showPlayer(localUrl: url, view: controller)
            } else {
            view?.isHiden = false
            downloadTrack?.download()
            downloadTrack?.complition = { [ weak self ] in
                self?.router?.showPlayer(localUrl: self?.downloadTrack?.localUrlTrack, view: controller)
                self?.view?.compliteLoading()
                self?.view?.isHiden = true
            }
        }
    }
}
//MARK: - DownloadTrackDelegate
extension DetailsPresenter: DownloadTrackDelegate {
    func progressTransfer(progress: Float, downloadSize: String) {
        view?.setDownloadView(progress: progress, downloadSize: downloadSize)
    }
}
