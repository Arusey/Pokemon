//
//  PokemonListViewModel.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class PokemonListViewModel {
    private(set) var all: [PokemonResultResponse] = []
    var query: String = ""
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    @ObservationIgnored
    let service: PokemonService

    init(service: PokemonService) {
        self.service = service
    }

    var filtered: [PokemonResultResponse] {
        guard !query.isEmpty else { return all }
        return all.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            let items = try await service.fetchFirstPokemons(limit: 100)
            self.all = items
        } catch {
            self.errorMessage = (error as NSError).localizedDescription
        }
        isLoading = false
    }
}
