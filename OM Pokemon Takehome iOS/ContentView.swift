//
//  ContentView.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import SwiftUI

struct ContentView: View {
    let viewModel: PokemonListViewModel

    var body: some View {
        PokemonListView(viewModel: viewModel)
    }
}

 
