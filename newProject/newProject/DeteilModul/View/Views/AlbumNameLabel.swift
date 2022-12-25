//
//  AlbumNameLabel.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 17.12.2022.
//

import UIKit

class AlbumNameLabel: UILabel {

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        text = "Album"
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Apple SD Gothic Neo Heavy", size: 20)
        textAlignment = .center
    }

}
