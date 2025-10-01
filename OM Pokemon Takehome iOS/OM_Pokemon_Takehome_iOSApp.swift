//
//  OM_Pokemon_Takehome_iOSApp.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import SwiftUI

@main
struct OM_Pokemon_Takehome_iOSApp: App {
    private let dependencies = AppDependencies()
    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: PokemonListViewModel(service: dependencies.pokemonService))
        }
    }
}
