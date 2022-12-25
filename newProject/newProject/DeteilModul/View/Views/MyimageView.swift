//
//  MyimageView.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 17.12.2022.
//

import UIKit

class MyimageView: UIImageView {

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure() {
       contentMode = .scaleToFill
       clipsToBounds = true
       translatesAutoresizingMaskIntoConstraints = false
       backgroundColor = .blue
    }
}
