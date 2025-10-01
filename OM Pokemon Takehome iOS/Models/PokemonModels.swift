//
//  PokemonModels.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResultResponse]
}

struct PokemonResultResponse: Decodable, Identifiable {
    let name: String
    let url: String

    var id: Int {
        let trimmed = url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if let idString = trimmed.split(separator: "/").last, let id = Int(idString) {
            return id
        }
        return name.hashValue
    }

    var displayName: String { name.capitalized }
}

struct PokemonDetail: Decodable {
    struct SpriteSet: Decodable {
        let frontDefault: String?
    }

    struct StatEntry: Decodable, Identifiable {
        let baseStat: Int
        let effort: Int
        let stat: NamedAPIResourceLite
        var id: String { stat.name }
    }

    struct TypeEntry: Decodable, Identifiable {
        let slot: Int
        let type: NamedAPIResourceLite
        var id: String { type.name }
    }

    struct AbilityEntry: Decodable, Identifiable {
        let isHidden: Bool
        let slot: Int
        let ability: NamedAPIResourceLite
        var id: String { ability.name }
    }

    struct NamedAPIResourceLite: Decodable { let name: String }

    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: SpriteSet
    let stats: [StatEntry]
    let types: [TypeEntry]
    let abilities: [AbilityEntry]

    var displayName: String { name.capitalized }

    var imageURL: URL? {
        sprites.frontDefault.flatMap(URL.init(string:))
    }
}
