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
    func completeLoading()
    func endDownload()
}

class DetailView: UIViewController {
    //MARK: - Propertys
    private let downloadProgress = UIProgressView()
    private let downloadLabel = UILabel()
    private let downloadButton = LoadButton()
    private var detailImage = MyimageView(frame: .zero)
    private let nameLabel = NameLabel()
    private let trackNameLabel = TrackNameLabel()
    private let albumNameLabel = AlbumNameLabel()
    private let lottiView = LottiImagesView()
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
    var presenter: DetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        setConstraints()
    }
    //MARK: - @objc
    @objc func downloadTap() {
        presenter.downLoadTrack()
    }
}
//MARK: - DetailViewProtocol
extension DetailView: DetailViewProtocol {
    func completeLoading() {
        downloadButton.isDownload = isHiden
    }
    
    func setController(track: Track?, image: UIImage?) {
        nameLabel.text = track?.artistName
        trackNameLabel.text = track?.trackName
        albumNameLabel.text = track?.collectionCensoredName
        detailImage.image = image
    }
    
    func setDownloadView(progress: Float, downloadSize: String) {
        downloadLabel.text = downloadSize
        downloadProgress.progress = progress
        lottiView.progress(to: CGFloat(progress))
    }
    func endDownload() {
        lottiView.endDownload()
    }
}
//MARK: - Private func
extension DetailView {
    private func isHidden() {
        downloadLabel.isHidden = isHiden
        downloadProgress.isHidden = isHiden
    }
    
    private func setViews() {
        view.backgroundColor = .white
        stack.alignment = .center
        view.addSubview(stack)
        view.addSubview(downloadButton)
        view.addSubview(downloadProgress)
        view.addSubview(downloadLabel)
        view.addSubview(lottiView)
        downloadProgress.translatesAutoresizingMaskIntoConstraints = false
        downloadLabel.translatesAutoresizingMaskIntoConstraints = false
        isHidden()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailImage.heightAnchor.constraint(equalToConstant: 130),
            detailImage.widthAnchor.constraint(equalToConstant: 130),
            
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            downloadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadLabel.bottomAnchor.constraint(equalTo: downloadProgress.topAnchor, constant: -10),
            
            lottiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottiView.heightAnchor.constraint(equalToConstant: 250),
            lottiView.widthAnchor.constraint(equalToConstant: 250),
            lottiView.bottomAnchor.constraint(equalTo: downloadProgress.topAnchor, constant: -20),
            
            downloadProgress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadProgress.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -30),
            
            downloadButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            downloadButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
