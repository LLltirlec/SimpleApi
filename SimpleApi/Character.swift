//
//  SimpleApi.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 19.06.2023.
//

import Foundation

struct CharacterFromCartoon: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SecInfo
    let location: SecInfo
    let image: URL
    let episode: [String]
}

struct SecInfo: Decodable {
    let name: String
    let url: String
}

struct Episode: Decodable {
    let name: String
    let airDate: String
    let episode: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
    }
}
