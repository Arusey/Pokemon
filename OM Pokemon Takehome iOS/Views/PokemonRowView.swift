//
//  PokemonRowView.swift
//  OM Pokemon Takehome iOS
//
//  Created by Kevin Lagat Home PC on 01/10/2025.
//

import SwiftUI

struct PokemonRowView: View {
    let item: PokemonResultResponse
    let service: PokemonService

    @State private var spriteURL: URL?
    @State private var didLoad = false

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: spriteURL) { phase in
                switch phase {
                case .success(let image): image.resizable().scaledToFit()
                case .failure(_): Image(systemName: "photo").resizable().scaledToFit().foregroundStyle(.secondary)
                case .empty: ProgressView()
                @unknown default: Color.gray.opacity(0.2)
                }
            }
            .frame(width: 56, height: 56)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(item.displayName).font(.headline)
                Text("#\(item.id)").font(.subheadline).foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 6)
        .task(id: item.id) { await loadSprite() }
    }

    @MainActor
    private func loadSprite() async {
        guard !didLoad else { return }
        didLoad = true
        do {
            let detail = try await service.fetchDetail(id: item.id)
            spriteURL = detail.imageURL
        } catch {
            debugPrint("Oops we have an error here \(error)")
        }
    }
}

 
