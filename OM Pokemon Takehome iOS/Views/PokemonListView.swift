//
//  PokemonListView.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import SwiftUI
import Observation

struct PokemonListView: View {
    @State var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.all.isEmpty {
                    ProgressView("Loading Pokémon…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage, viewModel.all.isEmpty {
                    VStack(spacing: 12) {
                        Text("Something went wrong")
                            .font(.headline)
                        Text(error)
                            .foregroundStyle(.secondary)
                        Button(action: { Task { await viewModel.load() } }) {
                            Text("Retry")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    List(viewModel.filtered) { item in
                        NavigationLink(value: item.id) {
                            PokemonRowView(item: item, service: viewModel.service)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Mini Pokédex")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.red.opacity(0.1), for: .navigationBar)
            .navigationDestination(for: Int.self) { id in
                PokemonDetailView(viewModel: PokemonDetailViewModel(id: id, service: viewModel.service))
            }
        }
        .task { await viewModel.load() }
        .searchable(
            text: Binding(get: { viewModel.query }, set: { viewModel.query = $0 }),
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search Pokémon"
        )
    }
}

 
