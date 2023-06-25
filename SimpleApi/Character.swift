//
//  SimpleApi.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 19.06.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Character]
    
    init(results: [Character]) {
        self.results = results
    }
    
    static func getChar(data: Any) -> [Character]{
        guard let data = data as? [String: Any] else { return [] }
        guard let data = data["results"] as? [[String: Any]] else { return [] }
        return data.map { Character(character: $0) }
    }
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SecInfo
    let location: SecInfo
    let image: String
    let episode: [String]
    
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
    
    init(character: [String: Any]) {
        name = character["name"] as? String ?? ""
        status = character["status"] as? String ?? ""
        species = character["species"] as? String ?? ""
        type = character["type"] as? String ?? ""
        gender = character["gender"] as? String ?? ""
        origin = SecInfo.init(info: character)
        location = SecInfo.init(info: character)
        image = character["image"] as? String ?? ""
        episode = character["episode"] as? [String] ?? []
    }
    
    init(name: String, status: String, species: String, type: String, gender: String, origin: SecInfo, location: SecInfo, image: String, episode: [String]) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
    }
}

struct SecInfo: Decodable {
    let name: String
    
    init(info:[String: Any]){
        name = info["name"] as? String ?? ""
    }
    
    init(name: String) {
        self.name = name
    }
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
