//
//  DetailView.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import UIKit
//MARK: - DetailViewProtocol 
protocol DetailViewProtocol: AnyObject {
    var isHiden: Bool { get set }
    func setController(track: Track?, image: UIImage?)
    func setDownloadView(progress: Float, downloadSize: String)
    func compliteLoading()
}

class DetailView: UIViewController {
    //MARK: -Propertis
    private let downloadProgres = UIProgressView()
    private let downloadLable = UILabel()
    private let downloadBatton = LoadButton()
    private var detailImage = MyimageView(frame: .zero)
    private let nameLabel = NameLabel()
    private let trackNameLabel = TrackNameLabel()
    private let albumNameLabel = AlbumNameLabel()
    private lazy var stack = UIStackView(
        arrangedSubViews: [
            detailImage,
            nameLabel,
            trackNameLabel,
            albumNameLabel
        ],
        axis: .vertical,
        spacing: 20
    )
    var isHiden = true {
        didSet {
          isHidden()
        }
    }
    var presentor: DetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        setConsreints()
    }
    //MARK: - @objc
    @objc func downloadTap() {
        presentor.downLoadTrack()
    }
}
//MARK: - DetailViewProtocol
extension DetailView: DetailViewProtocol {
    func compliteLoading() {
        downloadBatton.isDownload = isHiden
    }
    
    func setController(track: Track?, image: UIImage?) {
        nameLabel.text = track?.artistName
        trackNameLabel.text = track?.trackName
        albumNameLabel.text = track?.collectionCensoredName
        detailImage.image = image
        }
    
    func setDownloadView(progress: Float, downloadSize: String) {
        downloadLable.text = downloadSize
        downloadProgres.progress = progress
    }
}
//MARK: - Private func
extension DetailView {
    private func isHidden() {
        downloadLable.isHidden = isHiden
        downloadProgres.isHidden = isHiden
    }

    private func setViews() {
        view.backgroundColor = .white
        stack.alignment = .center
        view.addSubview(stack)
        view.addSubview(downloadBatton)
        view.addSubview(downloadProgres)
        view.addSubview(downloadLable)
        downloadProgres.translatesAutoresizingMaskIntoConstraints = false
        downloadLable.translatesAutoresizingMaskIntoConstraints = false
        isHidden()
    }
    
    private func setConsreints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailImage.heightAnchor.constraint(equalToConstant: 130),
            detailImage.widthAnchor.constraint(equalToConstant: 130),
            
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        
            downloadLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadLable.bottomAnchor.constraint(equalTo: downloadProgres.topAnchor, constant: -10),
            
            downloadProgres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadProgres.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadProgres.bottomAnchor.constraint(equalTo: downloadBatton.topAnchor, constant: -30),
            
            downloadBatton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            downloadBatton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            downloadBatton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
