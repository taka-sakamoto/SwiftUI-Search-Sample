//
//  CatDetailView.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/02.
//

import SwiftUI
import CoreData

struct CatDetailView: View {
    
    let cat: Cat
    let breed: Breed

    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: FavoriteViewModel
    
    init(cat: Cat, breed: Breed) {
        self.cat = cat
        self.breed = breed
        _viewModel = StateObject(
            wrappedValue: FavoriteViewModel(
                context: PersistenceController.shared.container.viewContext
            )
        )
    }

    var body: some View {
        VStack {
            
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: cat.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                        
                    case .failure:
                        Image(systemName: "photo")
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Button {
                    if viewModel.isFavorite(cat: cat) {
                        viewModel.removeFavorite(cat: cat)
                    } else {
                        viewModel.addFavorite(cat: cat)
                    }
                } label: {
                    Image(systemName: viewModel.isFavorite(cat: cat) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.system(size: 28))
                        .shadow(radius: 3)
                        .padding(12)
                        .contentShape(Rectangle())
                }
                .offset(x: 10, y: -10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                    
                Text(breed.name)
                    .font(.title)
                    .fontWeight(.bold)
                    
                Text("性格: \(breed.temperament ?? "不明")")
                Text("原産国: \(breed.origin ?? "不明")")
                
            }
            .padding()
            
            Spacer()
            
        }
        .navigationTitle("Cat Detail")
        .padding()
        
        
    }
    
}

/*
#Preview {
    CatDetailView()
}
*/
