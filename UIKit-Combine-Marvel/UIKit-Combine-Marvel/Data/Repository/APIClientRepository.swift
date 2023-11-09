//
//  APIClientRepository.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

// MARK: - APIClientRepository -
final class APIClientRepository: APIClientRepositoryProtocol {
    // MARK: - Properties -
    private var apiClient: APIClientProtocol
    
    // MARK: - Initializers -
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Functions -
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults {
        try await apiClient.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults {
        try await apiClient.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId))
    }
}
