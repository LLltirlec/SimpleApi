//
//  SimpleApi.swift
//  SimpleApi
//
//  Created by Евгений Ефимов on 19.06.2023.
//

struct CharacterFromCartoon: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct Location: Decodable {
    let name: String
    let url: String
}