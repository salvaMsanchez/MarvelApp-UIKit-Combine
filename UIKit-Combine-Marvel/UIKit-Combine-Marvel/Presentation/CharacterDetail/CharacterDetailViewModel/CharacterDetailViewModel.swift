//
//  CharacterDetailViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 9/11/23.
//

import Foundation

// MARK: - CharacterDetailViewState -
enum CharacterDetailViewState {
    case none, loading, loaded, error
}

// MARK: - CharacterDetailViewModel -
final class CharacterDetailViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var state: CharacterDetailViewState = .none
    @Published var series: Series = []
    var seriesCount: Int {
        series.count
    }
    var character: Character?
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(useCase: APIClientUseCaseProtocol = APIClientUseCase(), character: Character) {
        self.useCase = useCase
        self.character = character
    }
    
    // MARK: - Functions -
    func loadSeries() {
        state = .loading
        DispatchQueue.global().async {
            Task.init { [weak self] in
                do {
                    guard let characterId = self?.character?.id else {
                        return
                    }
                    guard let seriesResults = try await self?.useCase.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId)) else {
                        return
                    }
                    let series = seriesResults.series.filter { $0.description != nil }
                    
                    self?.series = series
                    self?.state = .loaded
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func serieBy(index: Int) -> Serie? {
        if index >= 0 && index < seriesCount {
            return series[index]
        } else {
            return nil
        }
    }
}
