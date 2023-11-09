//
//  CharacterDetailViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import Foundation

enum CharacterDetailViewState {
    case none, loading, loaded, error
}

final class CharacterDetailViewModel: ObservableObject {
    
    @Published var state: CharacterDetailViewState = .none
    @Published var series: Series = []
    
    let useCase: APIClientUseCaseProtocol
    
    init(useCase: APIClientUseCaseProtocol = APIClientUseCase()) {
        self.useCase = useCase
    }
    
    func loadSeries(with characterId: Int) {
        defer {
            state = .loaded
        }
        state = .loading
        DispatchQueue.global().async {
            Task.init { [weak self] in
                do {
                    guard let seriesResults = try await self?.useCase.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId)) else {
                        return
                    }
                    let series = seriesResults.series.filter { $0.description != nil }
                    self?.series = series
                } catch {
                    print(error)
                }
            }
        }
    }
}
