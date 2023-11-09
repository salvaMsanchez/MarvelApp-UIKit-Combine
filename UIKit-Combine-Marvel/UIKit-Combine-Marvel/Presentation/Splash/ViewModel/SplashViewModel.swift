//
//  SplashViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

// MARK: - SplashViewState -
enum SplashViewState {
    case none, loading, loaded, error
}

// MARK: - SplashViewModel -
final class SplashViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var state: SplashViewState = .none
    
    // MARK: - Initializers -
    init() {
        checkDataStatus()
    }
    
    // MARK: - Functions -
    func checkDataStatus() {
        state = .loading
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.state = .loaded
        }
    }
}
