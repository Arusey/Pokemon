//
//  PokemonService.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import Foundation

protocol PokemonService {
    func fetchFirstPokemons(limit: Int) async throws -> [PokemonResultResponse]
    func fetchDetail(id: Int) async throws -> PokemonDetail
}

struct DefaultPokemonService: PokemonService {
    private let api: APIClient
    private let base = URL(string: "https://pokeapi.co/api/v2")!

    init(api: APIClient) { self.api = api }

    func fetchFirstPokemons(limit: Int) async throws -> [PokemonResultResponse] {
        var comps = URLComponents(url: base.appendingPathComponent("pokemon"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "limit", value: String(limit)),
            .init(name: "offset", value: "0")
        ]
        let list: PokemonListResponse = try await api.get(comps.url!)
        return list.results
    }

    func fetchDetail(id: Int) async throws -> PokemonDetail {
        let url = base.appendingPathComponent("pokemon/\(id)")
        return try await api.get(url)
    }
}
