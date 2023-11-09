//
//  CharacterDetailHeaderView.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import UIKit

// MARK: - CharacterDetailHeaderView -
final class CharacterDetailHeaderView: UICollectionReusableView {
    // MARK: - Static properties -
    static let identifier = "CharacterDetailHeaderView"
    
    // MARK: - UI elements -
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "main")
        
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
        addSubview(headerImage)
        addSubview(headerLabel)
    }
    
    private func applyConstraints() {
        let headerImageConstraints = [
            headerImage.topAnchor.constraint(equalTo: topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImage.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -24),
            headerImage.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let headerLabelConstraints = [
//            headerLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(headerImageConstraints)
        NSLayoutConstraint.activate(headerLabelConstraints)
    }
    
    func configure(with model: CharacterProperties) {
        headerImage.kf.setImage(with: URL(string: model.thumbnail.path + ".jpg"))
        headerLabel.text = model.description
    }
}
