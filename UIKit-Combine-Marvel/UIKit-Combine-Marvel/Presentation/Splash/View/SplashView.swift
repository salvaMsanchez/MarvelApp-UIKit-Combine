//
//  SplashView.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import UIKit
import Lottie

// MARK: - SplashView -
final class SplashView: UIView {
    // MARK: - UI elements -
    public let splashAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "marvelSplashAnimation")
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
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
        addSubview(splashAnimationView)
    }

    private func applyConstraints() {
        let splashAnimationViewConstraints = [
            splashAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            splashAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            splashAnimationView.heightAnchor.constraint(equalToConstant: 300),
            splashAnimationView.widthAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(splashAnimationViewConstraints)
    }
}

