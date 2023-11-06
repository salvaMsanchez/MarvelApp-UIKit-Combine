//
//  APIClientRepository.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

final class APIClientRepository: APIClientRepositoryProtocol {
    
    private var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        try await apiClient.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
}
