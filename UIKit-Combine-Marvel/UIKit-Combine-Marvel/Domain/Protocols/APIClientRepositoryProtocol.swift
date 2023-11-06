//
//  APIClientRepositoryProtocol.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

protocol APIClientRepositoryProtocol {
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
}
