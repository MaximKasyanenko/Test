//
//  LoadButton.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 17.12.2022.
//

import UIKit

class LoadButton: UIButton {
    var isDownload = true {
        didSet {
            if self.isDownload {
                setTitle("Download", for: .normal)
            } else {
                setTitle("Play", for: .normal)
            }
        }
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Download", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 5
        addTarget(nil, action: #selector(DetailView.downloadTap), for: .touchUpInside)
        addTarget(self, action: #selector(tupIn), for: [
            .touchDown,
            .touchDragInside
        ])
        addTarget(self, action: #selector(tupOut), for: [
            .touchDragOutside,
            .touchUpInside,
            .touchDragExit,
            .touchCancel
        ])
    }
    @objc func tupIn() {
        UIView.animate(withDuration: 0.15) { [ weak self ] in
            self?.alpha = 0.5
            self?.backgroundColor = #colorLiteral(red: 0.6226878762, green: 0.6226878762, blue: 0.6226878762, alpha: 1)
        }
    }
    @objc func tupOut() {
        UIView.animate(withDuration: 0.15) { [ weak self ] in
            self?.alpha = 1
            self?.backgroundColor = .clear
        }
    }

}
