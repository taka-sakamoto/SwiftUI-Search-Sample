//
//  FavoritesView.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/06.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: FavoriteCat.entity(),
                  sortDescriptors: []
    ) var favorites: FetchedResults<FavoriteCat>
    
    var body: some View {
        if favorites.isEmpty {
            VStack {
                Spacer()
                
                VStack(spacing: 12) {
                    Image(systemName: "heart")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    
                    Text("お気に入りはありません\n気になる猫を追加してみましょう")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.8))
                        .lineSpacing(4)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            
            List {
                ForEach(favorites) { cat in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        if let url = URL(string: cat.imageUrl ?? "") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(10)
                        }
                        
                        Text(cat.name ?? "Cat")
                            .font(.headline)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    
                }
                .onDelete { IndexSet in
                    for index in IndexSet {
                        let cat = favorites[index]
                        context.delete(cat)
                    }
                    try? context.save()
                }
            }
            .navigationTitle("Favorites")
        }
       
        
    }
}

/*
#Preview {
    FavoritesView()
}
*/
