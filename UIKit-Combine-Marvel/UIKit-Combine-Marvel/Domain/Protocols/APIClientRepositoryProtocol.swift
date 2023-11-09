//
//  APIClientRepositoryProtocol.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

// MARK: - APIClientRepositoryProtocol -
protocol APIClientRepositoryProtocol {
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults
}
