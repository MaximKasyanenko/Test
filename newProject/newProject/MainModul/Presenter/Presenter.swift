//
//  Presenter.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import UIKit
//MARK: - PresenterProtocol 
protocol PresenterProtocol: AnyObject {
    var router: RouterProtocol? { get }
    var tracks: [Track]? { get }
    init(view: MainViewProtocol, router: RouterProtocol)
    func getTrack(serch: String)
    func getImage(url: String, complition: @MainActor @escaping (Data) -> ())
    func ingectionTrack(track: Track, image: UIImage?)
    func cellData(indexPath: IndexPath, cell: MainTableViewCell) 
}
//MARK: - Presenter
final class MainPresenter: PresenterProtocol {
    var tracks: [Track]? { trackService.tracks }
    var router: RouterProtocol?
    private weak var view: MainViewProtocol?
    private let trackService = TrackService()

    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        trackService.trackUpdateHandler = { [weak self] in
            self?.view?.reloadTableView()
        }
    }
    //MARK: - Func
    @MainActor func getTrack(serch: String)  {
        trackService.getTrack(serch: serch)
    }
    
    func getImage(url: String, complition: @MainActor @escaping (Data) -> ()) {
        trackService.getImage(url: url, complition: complition)
    }
    
    func ingectionTrack(track: Track, image: UIImage?) {
        router?.showDetails(track: track, image: image)
    }
    
    func cellData(indexPath: IndexPath, cell: MainTableViewCell) {
        let track = tracks?[indexPath.row]
        getImage(url: track?.artworkUrl60 ?? "") { data in
            let image = UIImage(data: data)
            cell.configur(track: track?.trackName, image: image)
        }
    }
}
