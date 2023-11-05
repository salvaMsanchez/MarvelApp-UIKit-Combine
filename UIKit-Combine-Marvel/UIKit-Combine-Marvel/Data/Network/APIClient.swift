//
//  APIClient.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

struct Constants {
    static let apikey = "4837bc10899562b5f7ebc30e1656c4b9"
    static let ts = "1"
    static let hash = "05418622293818d89a3ede300147d088"
    static let orderBy = "-modified"
}

protocol APIClientProtocol {
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
}

// MARK: - APIRouter -
enum APIRouter {
    case getCharacter
    
    var host: String {
        switch self {
            case .getCharacter:
                return "gateway.marvel.com"
        }
    }
    
    var scheme: String {
        switch self {
            case .getCharacter:
                return "https"
        }
    }
    
    var path: String {
        switch self {
            case .getCharacter:
                return "/v1/public/characters"
        }
    }
    
    var method: String {
        switch self {
            case .getCharacter:
                return "GET"
        }
    }
}

// MARK: - APIClient -
final class APIClient: APIClientProtocol {
    // MARK: - APIError -
    enum APIError: Error {
        case unknown
        case malformedUrl
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code: Int?)
    }
    
    // MARK: - Functions -
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        
        // Define los parámetros
        let apiKeyItem = URLQueryItem(name: "apikey", value: Constants.apikey)
        let tsItem = URLQueryItem(name: "ts", value: Constants.ts)
        let hashItem = URLQueryItem(name: "hash", value: Constants.hash)
        let orderByItem = URLQueryItem(name: "orderBy", value: Constants.orderBy)
        let nameItem = URLQueryItem(name: "name", value: characterName)

        // Agrega los parámetros a la URL
        components.queryItems = [apiKeyItem, tsItem, hashItem, orderByItem, nameItem]
        
        guard let url = components.url else {
            throw APIError.malformedUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRouter.method
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let statusCode = response.getStatusCode()
        guard statusCode == 200 else {
            throw APIError.statusCode(code: statusCode)
        }
        
        guard !data.isEmpty else {
            throw APIError.noData
        }
        
        guard let resource = try? JSONDecoder().decode(Character.self, from: data) else {
            throw APIError.decodingFailed
        }
        
        return resource
    }
}

// MARK: - Fake Success -
//final class APIClientFakeSuccess: APIClientProtocol {
//    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
//        // TODO: Do
//    }
//}

// MARK: - Fake Error -
//final class APIClientFakeError: APIClientProtocol {
//    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
//        // TODO: Do
//    }
//}
