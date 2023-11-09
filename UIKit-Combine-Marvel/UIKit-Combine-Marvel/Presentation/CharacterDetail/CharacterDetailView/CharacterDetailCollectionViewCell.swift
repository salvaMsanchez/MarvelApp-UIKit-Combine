//
//  CharacterDetailView.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import UIKit
import Kingfisher

// MARK: - CharacterDetailCollectionViewCell -
final class CharacterDetailCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties -
    static let identifier = "CharacterDetailCollectionViewCell"
    
    // MARK: - UI components -
    private let serieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let serieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(named: "main")
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions -
    private func setup() {
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(serieImageView)
        contentView.addSubview(serieNameLabel)
    }
    
    private func applyConstraints() {
        let serieImageViewConstraints = [
            serieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            serieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            serieImageView.bottomAnchor.constraint(equalTo: serieNameLabel.topAnchor, constant: -8),
            serieImageView.heightAnchor.constraint(equalToConstant: 160)
        ]
        
        let serieNameLabelConstraints = [
            serieNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            serieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(serieImageViewConstraints)
        NSLayoutConstraint.activate(serieNameLabelConstraints)
    }
    
    func configure(with model: Serie) {
        serieNameLabel.text = model.title
        serieImageView.kf.setImage(with: URL(string: model.thumbnail.path + "." + model.thumbnail.thumbnailExtension))
    }
}
