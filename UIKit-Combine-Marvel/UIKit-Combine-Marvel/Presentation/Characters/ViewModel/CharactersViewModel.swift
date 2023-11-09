//
//  CharactersViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 6/11/23.
//

import Foundation

let charactersToUse: [String] = ["Iron Man",
                                "Hulk",
                                "Wolverine",
                                "Thor",
                                "Spider-Man (Peter Parker)",
                                "Avengers",
                                "Captain America",
                                "Guardians of the Galaxy",
                                "Wonder Man",
                                "X-Men"]

// MARK: - CharactersViewState -
enum CharactersViewState {
    case none, loading, loaded, error
}

// MARK: - CharactersViewModel -
final class CharactersViewModel: ObservableObject {
    // MARK: - Properties -
    let listCharacters: [String] = charactersToUse
    @Published var state: CharactersViewState = .none
    @Published var characters: Characters = []
    var charactersCount: Int {
        characters.count
    }
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(useCase: APIClientUseCaseProtocol = APIClientUseCase()) {
        self.useCase = useCase
    }
    
    // MARK: - Functions -
    func loadCharacters() {
        state = .loading
        
        DispatchQueue.global().async { [weak self] in
            let dispatchGroup = DispatchGroup()
            self?.listCharacters.forEach { nameCharacter in
                dispatchGroup.enter()
                Task.init { [weak self] in
                    defer {
                        dispatchGroup.leave()
                    }
                    do {
                        guard let character = try await self?.useCase.getCharacter(by: nameCharacter, apiRouter: .getCharacter) else {
                            return
                        }
                        self?.characters.append(contentsOf: character.characters)
                    } catch {
                        print(error)
                    }
                }
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.state = .loaded
            }
        }
    }
    
    func characterBy(index: Int) -> Character? {
        if index >= 0 && index < charactersCount {
            return characters[index]
        } else {
            return nil
        }
    }
}
