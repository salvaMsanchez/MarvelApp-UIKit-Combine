//
//  CharacterDetailViewController.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import UIKit
import Combine
import Lottie

final class CharacterDetailViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = CharacterDetailViewModel()
    
    // MARK: - UI elements -
    private let charactersCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    private let activityIndicatorUiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .black.withAlphaComponent(0.6)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let charactersAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "marvelCharactersAnimation")
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
