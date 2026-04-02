//
//  CatDetailView.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/02.
//

import SwiftUI

struct CatDetailView: View {
    
    let cat: Cat
    let breed: Breed

    var body: some View {
        VStack {
            
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
