//
//  Character.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

typealias Characters = [Character]

// MARK: - Character
struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: CharacterThumbnail
    let resourceURI: String
}

// MARK: - CharacterResults
struct CharacterResults: Decodable {
    let characters: Characters
    
    enum CodingKeys: String, CodingKey {
        case data
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.characters = try data.decode(Characters.self, forKey: .results)
    }
}

// MARK: - Thumbnail
struct CharacterThumbnail: Decodable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Extension
enum Extension: String, Decodable {
    case gif = "gif"
    case jpg = "jpg"
}
