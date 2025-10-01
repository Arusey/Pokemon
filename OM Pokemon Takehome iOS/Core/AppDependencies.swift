//
//  AppDependencies.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import Foundation

final class AppDependencies {
    let apiClient: APIClient
    let pokemonService: PokemonService

    init() {
        self.apiClient = PokemonAPIClient()
        self.pokemonService = DefaultPokemonService(api: apiClient)
    }
}
