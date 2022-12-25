//
//  NameLabel.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 17.12.2022.
//

import UIKit

class NameLabel: UILabel {

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        text = "Name"
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 25, weight: .medium)
       
        textAlignment = .center
    }
}
