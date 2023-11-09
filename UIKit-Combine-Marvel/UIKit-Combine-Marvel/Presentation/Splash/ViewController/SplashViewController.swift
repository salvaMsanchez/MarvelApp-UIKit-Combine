//
//  SplashViewController.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import UIKit
import Combine

// MARK: - SplashViewController -
final class SplashViewController: UIViewController {
    // MARK: - Properties -
    private let splashView = SplashView()
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = SplashViewModel()
    
    // MARK: - Lifecycle -
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$state
            .sink { data in
                DispatchQueue.main.async { [weak self] in
                    switch data {
                        case .none:
                            print("Estado Splash .none")
                        case .loading:
                            print("Estado Splash .loading")
                            self?.splashView.splashAnimationView.play()
                        case .loaded:
                            print("Estado Splash .loaded")
                            self?.splashView.splashAnimationView.stop()
                            let charactersViewController = CharactersViewController()
                            self?.navigationController?.setViewControllers([charactersViewController], animated: true)
                        case .error:
                            print("Estado Splash .error")
                    }
                }
            }
            .store(in: &subscriptions)
    }
}
