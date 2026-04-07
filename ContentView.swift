//
//  ContentView.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CatViewModel()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                List {
                    
                    if !viewModel.cats.isEmpty {
                        Button("← 猫種に戻る") {
                            viewModel.cats = []
                        }
                    }
                    
                    // 猫種リスト
                    if viewModel.cats.isEmpty {
                        ForEach(viewModel.filteredBreeds) { breed in
                            Button {
                                print("選択された: \(breed.name)")
                                viewModel.selectedBreed = breed
                                Task {
                                    await viewModel.fetchCatsByBreed(breedId: breed.id)
                                }
                            } label: {
                                Text(breed.name)
                            }
                        }
                    }
                    
                    // 猫画像
                    else {
                        ForEach(viewModel.cats) { cat in
                            NavigationLink {
                                if let breed = viewModel.selectedBreed {
                                    CatDetailView(cat: cat, breed: breed)
                                }
                            } label: {
                                
                                AsyncImage(url: URL(string: cat.url)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .background(Color.gray.opacity(0.1))
                                            
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .clipped()
                                            .cornerRadius(10)
                                            .padding(.vertical, 4)
                                            .transition(.opacity)
                                            
                                    case .failure:
                                        Image(systemName: "photo")
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .background(Color.gray.opacity(0.1))
                                            
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            .animation(.easeIn(duration: 0.3), value: viewModel.cats) // アニメーション
                        }
                    }
                }
                
                // 中央ローディング
                if viewModel.isLoading {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                    
                    ProgressView("Loading...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
                
            .navigationTitle(viewModel.cats.isEmpty ? "Cat Breeds" : "Cat Images")
            .searchable(text: $viewModel.query)
            .task {
                await viewModel.fetchBreeds()
            }
            .onChange(of: viewModel.query) {
                viewModel.cats = []
            }
            NavigationLink("お気に入り一覧") {
                FavoritesView()
            }
            
        }
    }
}


/*
#Preview {
    ContentView()
}
*/
