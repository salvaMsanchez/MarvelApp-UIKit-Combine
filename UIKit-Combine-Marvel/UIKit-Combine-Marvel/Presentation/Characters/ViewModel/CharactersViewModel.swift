//
//  CharactersViewModel.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 6/11/23.
//

import Foundation

enum CharactersViewState {
    case none, loading, loaded, error
}

final class CharactersViewModel: ObservableObject {
    
    let listCharacters: [String] = ["Iron Man",
                                    "Hulk",
                                    "Wolverine",
                                    "Thor",
                                    "Spider-Man (Peter Parker)",
                                    "Avengers",
                                    "Captain America",
                                    "Guardians of the Galaxy",
                                    "Wonder Man",
                                    "X-Men"]
    @Published var state: CharactersViewState = .none
    @Published var characters: [CharacterProperties] = []
    var charactersCount: Int {
        characters.count
    }
    
    let useCase: APIClientUseCaseProtocol
    
    init(useCase: APIClientUseCaseProtocol = APIClientUseCase()) {
        self.useCase = useCase
    }
    
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
                        self?.characters.append(contentsOf: character.character)
                    } catch {
                        print(error)
                    }
                }
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                print("Llamadas terminadas")
                self?.characters.forEach({ character in
                    print(character.name)
                })
                self?.state = .loaded
            }
        }
    }
    
    func characterBy(index: Int) -> CharacterProperties? {
        if index >= 0 && index < charactersCount {
            return characters[index]
        } else {
            return nil
        }
    }
}
