//
//  SplashViewController.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    
    let apiClient = APIClient()
    let listCharacters: [String] = ["Iron Man", "Hulk", "Doctor Strange", "Thor", "Spider-Man (Peter Parker)", "Spider-Girl (May Parker)", "Captain America"]
    var characters: [CharacterProperties] = []
    
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async { [weak self] in
            let dispatchGroup = DispatchGroup()
            self?.listCharacters.forEach { nameCharacter in
                dispatchGroup.enter()
                Task.init { [weak self] in
                    defer {
                        dispatchGroup.leave()
                    }
                    do {
                        guard let character = try await self?.apiClient.getCharacter(by: nameCharacter, apiRouter: .getCharacter) else {
                            return
                        }
                        self?.characters.append(contentsOf: character.character)
                    } catch {
                        print(error)
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                print("Llamadas terminadas")
            }
        }
        
    }
    
}
