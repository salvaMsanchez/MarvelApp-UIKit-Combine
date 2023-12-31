//
//  CharacterDetailViewController.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import UIKit
import Combine
import Lottie

// MARK: - CharacterDetailViewController -
final class CharacterDetailViewController: UIViewController {
    // MARK: - Properties -
    private var subscriptions = Set<AnyCancellable>()
    var viewModel: CharacterDetailViewModel?
    
    // MARK: - UI elements -
    private let characterDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 186)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "main")
        collectionView.register(CharacterDetailCollectionViewCell.self, forCellWithReuseIdentifier: CharacterDetailCollectionViewCell.identifier)
        collectionView.register(CharacterDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CharacterDetailHeaderView.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicatorDetailUiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .black.withAlphaComponent(0.6)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let characterDetailAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "marvelCharactersAnimation")
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.character?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = UIColor(named: "main")
        
        view.addSubview(characterDetailCollectionView)
        characterDetailCollectionView.dataSource = self
        characterDetailCollectionView.delegate = self
        
        setup()
        
        viewModel?.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                switch data {
                    case .none:
                        print("Characters Estado .none")
                    case .loading:
                        self?.characterDetailAnimationView.play()
                    case .loaded:
                        self?.characterDetailCollectionView.reloadData()
                        self?.characterDetailAnimationView.isHidden = true
                        self?.activityIndicatorDetailUiView.isHidden = true
                        self?.characterDetailAnimationView.stop()
                    case .error:
                        print("Characters Estado .error")
                }
            })
            .store(in: &subscriptions)
        
        viewModel?.loadSeries()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        characterDetailCollectionView.frame = view.bounds
    }
    
    // MARK: - Functions -
    private func setup() {
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        view.addSubview(activityIndicatorDetailUiView)
        activityIndicatorDetailUiView.addSubview(characterDetailAnimationView)
    }
    
    private func applyConstraints() {
        let activityIndicatorDetailUiViewConstraints = [
            activityIndicatorDetailUiView.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorDetailUiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorDetailUiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorDetailUiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let characterDetailAnimationViewConstraints = [
            characterDetailAnimationView.centerXAnchor.constraint(equalTo: activityIndicatorDetailUiView.centerXAnchor),
            characterDetailAnimationView.centerYAnchor.constraint(equalTo: activityIndicatorDetailUiView.centerYAnchor),
            characterDetailAnimationView.heightAnchor.constraint(equalToConstant: 300),
            characterDetailAnimationView.widthAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(activityIndicatorDetailUiViewConstraints)
        NSLayoutConstraint.activate(characterDetailAnimationViewConstraints)
    }
}

// MARK: - CharacterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate -
extension CharacterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCollectionViewCell.identifier, for: indexPath) as? CharacterDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let serie = viewModel?.serieBy(index: indexPath.row) {
            cell.configure(with: serie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.seriesCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CharacterDetailHeaderView.identifier, for: indexPath) as! CharacterDetailHeaderView
                if let character = viewModel?.character {
                    headerView.configure(with: character)
                }
                return headerView
            default:
                assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
}
