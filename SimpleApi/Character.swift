//
//  SimpleApi.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 19.06.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SecInfo
    let location: SecInfo
    let image: URL
    let episode: [URL]
    
    var descriprion: String {
        """
        Name: \(name)
        Status: \(status)
        Species: \(species)
        Gender: \(gender)
        Origin: \(origin.name)
        Location: \(location.name)
        """
    }
}

struct SecInfo: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}

enum RickAndMortyAPI {
    case baseURL
    
    var url: URL {
        switch self {
        case .baseURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}
