//
//  Character.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

// MARK: - Welcome
//struct Welcome: Decodable {
//    let code: Int
//    let status, copyright, attributionText, attributionHTML: String
//    let etag: String
//    let data: DataClass
//}

// MARK: - DataClass
//struct DataClass: Decodable {
//    let offset, limit, total, count: Int
//    let results: [Character]
//}

struct CharacterProperties: Codable {
    let id: Int
    let name: String
    let description: String
//    let modified: Date
    let thumbnail: CharacterThumbnail
    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
}

// MARK: - Result
struct Character: Decodable {
    let character: [CharacterProperties]
    
    enum CodingKeys: String, CodingKey {
        case data
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
//        let results = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .results)
        self.character = try data.decode([CharacterProperties].self, forKey: .results)
        
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
//        self.series = try container.decode(Comics.self, forKey: .series)
    }
}

//// MARK: - Comics
//struct Comics: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [ComicsItem]
//    let returned: Int
//}
//
//// MARK: - ComicsItem
//struct ComicsItem: Codable {
//    let resourceURI: String
//    let name: String
//}

//// MARK: - Stories
//struct Stories: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [StoriesItem]
//    let returned: Int
//}
//
//// MARK: - StoriesItem
//struct StoriesItem: Codable {
//    let resourceURI: String
//    let name: String
//    let type: ItemType
//}
//
//enum ItemType: String, Codable {
//    case cover = "cover"
//    case empty = ""
//    case interiorStory = "interiorStory"
//}
//
// MARK: - Thumbnail
struct CharacterThumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
//
enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
//
//// MARK: - URLElement
//struct URLElement: Codable {
//    let type: URLType
//    let url: String
//}
//
//enum URLType: String, Codable {
//    case comiclink = "comiclink"
//    case detail = "detail"
//    case wiki = "wiki"
//}
