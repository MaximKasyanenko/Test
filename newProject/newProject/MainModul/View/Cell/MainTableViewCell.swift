//
//  MainTableViewCell.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
   let myImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myImageView)
        addSubview(label)
        setConstreints()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configur(track: String?, image: UIImage?) {
        label.text = track
        myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    private func setConstreints() {
        myImageView.layer.cornerRadius = self.frame.height / 2 + 5
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            myImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            myImageView.widthAnchor.constraint(equalTo: myImageView.heightAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            label.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10)
        ])
    }
}
