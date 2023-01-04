//
//  LottiImage.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.01.2023.
//

import Lottie
import UIKit

class LottiImagesView: UIView {
    enum ProgressKeyFrames: CGFloat {
        case start = 0
        case end = 180
        case complete = 240
        
    }
    
    private let lottiImage: LottieAnimationView! = {
        let image = LottieAnimationView(name: "download2")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LottiImagesView {
    private func configure() {
        addSubview(lottiImage)
        translatesAutoresizingMaskIntoConstraints = false
       // isHidden = true
    }
    func setLayout() {
        NSLayoutConstraint.activate([
            lottiImage.topAnchor.constraint(equalTo: topAnchor),
            lottiImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            lottiImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            lottiImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
        func progress(to progress: CGFloat) {
      //  isHidden = false
        let progressRange = ProgressKeyFrames.end.rawValue - ProgressKeyFrames.start.rawValue
        let progressFrame = progressRange * progress
        let currentFrame = progressFrame + ProgressKeyFrames.start.rawValue
        lottiImage.currentFrame = currentFrame
        print(currentFrame)
        print("Downloading \((progress*100).rounded())%")
    }
    
       func endDownload() {
       // lottiImage.play(fromFrame: ProgressKeyFrames.end.rawValue, toFrame: ProgressKeyFrames.complete.rawValue, loopMode: .none) { (_) in
           // self.isHidden = true
      //  }
    }
}
