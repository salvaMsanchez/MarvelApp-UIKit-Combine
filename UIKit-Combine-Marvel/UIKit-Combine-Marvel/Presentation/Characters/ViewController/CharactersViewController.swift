//
//  CharactersViewController.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 6/11/23.
//

import UIKit
import Combine
import Lottie

// MARK: - CharactersViewController -
final class CharactersViewController: UIViewController {
    // MARK: - Properties -
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = CharactersViewModel()
    
    // MARK: - UI elements -
    private let charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "main")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
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
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(charactersTableView)
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
        setup()
        
        viewModel.$state
            .sink { data in
                DispatchQueue.main.async { [weak self] in
                    switch data {
                        case .none:
                            print("Characters Estado .none")
                        case .loading:
                            self?.charactersAnimationView.play()
                        case .loaded:
                            self?.charactersTableView.reloadData()
                            self?.charactersAnimationView.isHidden = true
                            self?.activityIndicatorUiView.isHidden = true
                            self?.charactersAnimationView.stop()
                        case .error:
                            print("Characters Estado .error")
                    }
                }
            }
            .store(in: &subscriptions)
        
        viewModel.loadCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        charactersTableView.frame = view.bounds
    }
    
    // MARK: - Functions -
    private func setup() {
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        view.addSubview(activityIndicatorUiView)
        activityIndicatorUiView.addSubview(charactersAnimationView)
    }
    
    private func applyConstraints() {
        let activityIndicatorUiViewConstraints = [
            activityIndicatorUiView.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorUiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorUiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorUiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let charactersAnimationViewConstraints = [
            charactersAnimationView.centerXAnchor.constraint(equalTo: activityIndicatorUiView.centerXAnchor),
            charactersAnimationView.centerYAnchor.constraint(equalTo: activityIndicatorUiView.centerYAnchor),
            charactersAnimationView.heightAnchor.constraint(equalToConstant: 300),
            charactersAnimationView.widthAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(activityIndicatorUiViewConstraints)
        NSLayoutConstraint.activate(charactersAnimationViewConstraints)
    }
    
    private func onCharacterCellPressed(model: Character) {
        let characterDetailViewController = CharacterDetailViewController()
        characterDetailViewController.viewModel = CharacterDetailViewModel(character: model)
        self.navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}

// MARK: - CharactersViewController: UITableViewDataSource, UITableViewDelegate -
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        if let character = viewModel.characterBy(index: indexPath.row) {
            cell.configure(with: character)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let character = viewModel.characterBy(index: indexPath.row) {
            onCharacterCellPressed(model: character)
        }
    }
}
