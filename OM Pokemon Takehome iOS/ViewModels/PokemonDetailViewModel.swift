//
//  PokemonDetailViewModel.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class PokemonDetailViewModel {
    private(set) var detail: PokemonDetail?
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    let id: Int
    @ObservationIgnored
    private let service: PokemonService

    init(id: Int, service: PokemonService) {
        self.id = id
        self.service = service
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            detail = try await service.fetchDetail(id: id)
        } catch {
            errorMessage = (error as NSError).localizedDescription
        }
        isLoading = false
    }
}
