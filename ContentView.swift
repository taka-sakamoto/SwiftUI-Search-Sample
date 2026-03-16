//
//  ContentView.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/03/16.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CatViewModel()
    @State private var searchText = ""
    @State private var isLoading = false
    
  
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                if isLoading {
                    ProgressView()
                        .padding()
                }
                
                List(viewModel.cats) { cat in
                    
                    AsyncImage(url: URL(string: cat.url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Cat Search")
            .searchable(text: $searchText, prompt: "キーワードを入力")
            .onSubmit(of: .search) {
                Task {
                    await searchCats()
                }
            }
        }
    }
    // 非同期で検索
    private func searchCats() async {
        isLoading = true
        await viewModel.fetchCats(query: searchText)
        isLoading = false
    }
    
    
}


/*
#Preview {
    ContentView()
}
*/
