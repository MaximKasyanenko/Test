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
    init(view: MainViewProtocol, router: RouterProtocol, trackServise: TrackServiceProtocol)
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
    private var trackService: TrackServiceProtocol
    
    required init(view: MainViewProtocol, router: RouterProtocol, trackServise: TrackServiceProtocol) {
        self.view = view
        self.router = router
        self.trackService = trackServise
        trackService.trackUpdateHandler = { [weak self] in
            self?.view?.reloadTableView()
        }
    }
    //MARK: - Func
     func getTrack(serch: String)  {
         let text = validate(text: serch)
        trackService.getTrack(serch: text)
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
    
    private func validate(text: String) -> String {
        let text = text.replacingOccurrences(of: " ", with: "+")
        return text
    }
}
