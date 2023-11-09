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
    var seriesCount: Int {
        series.count
    }
    var character: CharacterProperties?
    
    let useCase: APIClientUseCaseProtocol
    
    init(useCase: APIClientUseCaseProtocol = APIClientUseCase(), character: CharacterProperties) {
        self.useCase = useCase
        self.character = character
    }
    
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
                    print(self?.series)
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
