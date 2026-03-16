//
//  CatViewModel.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/03/16.
//

import SwiftUI
import Foundation
import Combine

class CatViewModel: ObservableObject {
    
    @Published var cats: [Cat] = []
    
    func fetchCats(query: String) async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else {
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Cat].self, from: data)
            
            DispatchQueue.main.async {
                self.cats = decoded
            }
        } catch {
            print(error)
        }
    }
}

    /*
#Preview {
    CatViewModel()
}
*/
