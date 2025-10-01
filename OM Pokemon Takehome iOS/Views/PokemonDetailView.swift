//
//  PokemonDetailView.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    @State var viewModel: PokemonDetailViewModel

    init(viewModel: PokemonDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            if let detail = viewModel.detail {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: detail.imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable().scaledToFit()
                            case .failure(_):
                                Image(systemName: "photo").resizable().scaledToFit().foregroundStyle(.secondary)
                            case .empty:
                                ProgressView()
                            @unknown default:
                                Color.gray.opacity(0.2)
                            }
                        }
                        .frame(height: 180)

                        Text(detail.displayName)
                            .font(.title).bold()
                        Text("#\(detail.id)")
                            .foregroundStyle(.secondary)

                        if !detail.types.isEmpty {
                            let typeNames = detail.types.map { $0.type.name.capitalized }.joined(separator: ", ")
                            LabeledContent("Types", value: typeNames)
                        }

                        LabeledContent("Height", value: String(format: "%.1f m", Double(detail.height)/10.0))
                        LabeledContent("Weight", value: String(format: "%.1f kg", Double(detail.weight)/10.0))

                        if !detail.abilities.isEmpty {
                            let abilityNames = detail.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")
                            LabeledContent("Abilities", value: abilityNames)
                        }

                        if !detail.stats.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stats").font(.headline)
                                ForEach(detail.stats) { stat in
                                    HStack {
                                        Text(stat.stat.name.capitalized)
                                        Spacer()
                                        Text("\(stat.baseStat)")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            } else if viewModel.isLoading {
                ProgressView("Loading…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text("Failed to load details").font(.headline)
                    Text(error).foregroundStyle(.secondary)
                    Button("Retry") { Task { await viewModel.load() } }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationTitle(viewModel.detail?.displayName ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.load() }
    }
}

 
