//
//  SplashViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

enum SplashViewState {
    case none, loading, loaded, error
}

final class SplashViewModel: ObservableObject {
    
    @Published var state: SplashViewState = .none
    
    init() {
        checkDataStatus()
    }
    
    func checkDataStatus() {
        state = .loading
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.state = .loaded
        }
    }
}
