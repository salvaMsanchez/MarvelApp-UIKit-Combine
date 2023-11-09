//
//  CharactersView.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 6/11/23.
//

import UIKit
import Kingfisher

final class CharacterTableViewCell: UITableViewCell {
    // MARK: - Static properties -
    static let identifier = "CharacterTableViewCell"
    // MARK: - Private properties -
    private var gradientAdded = false
    
    // MARK: - UI components -
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "ironman")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.01, 0.1, 0.7, 1.0]
        gradientLayer.frame = characterImageView.bounds
        characterImageView.layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Initializers -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "main")
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.frame = contentView.bounds
        
        if !gradientAdded && characterImageView.bounds != .zero {
            addGradient()
            characterImageView.addSubview(characterNameLabel)
            gradientAdded = true
        }
    }
    
    // MARK: - Functions -
    private func setup() {
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(characterImageView)
        characterImageView.addSubview(characterNameLabel)
    }
    
    private func applyConstraints() {
        let characterNameLabelConstraints = [
            characterNameLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -12),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(characterNameLabelConstraints)
    }
    
    func configure(with model: CharacterProperties) {
        characterNameLabel.text = model.name
        characterImageView.kf.setImage(with: URL(string: model.thumbnail.path + ".jpg"))
    }
}
