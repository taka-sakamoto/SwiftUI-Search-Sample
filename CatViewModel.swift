//
//  CatViewModel.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/03/16.
//

import SwiftUI
import Foundation
import Combine
import CoreData

class CatViewModel: ObservableObject {
    
    @Published var cats: [Cat] = []
    @Published var query: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var breeds: [Breed] = []
    @Published var selectedBreed: Breed?
    
    
    
    func fetchCats() async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Cat].self, from: data)
            
            await MainActor.run {
                self.cats = decoded
            }
            
        } catch {
            print(error)
        }
    }
    
    func fetchBreeds() async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else {
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Breed].self, from: data)
           
            await MainActor.run {
                self.breeds = decoded
            }
            
        } catch {
            print(error)
        }
        
    }
    
    var filteredBreeds: [Breed] {
        if query.isEmpty {
            return breeds
        } else {
            return breeds.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
    }
    
    func fetchCatsByBreed(breedId: String) async {
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=\(breedId)"
        
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Cat].self, from: data)
            

            await MainActor.run {
                if decoded.isEmpty {
                    print("画像なし → 通常取得")
                    Task {
                        await self.fetchCats()
                    }
                } else {
                    self.cats = decoded
                }
                self.isLoading = false
            }
            
            
        } catch {
            await MainActor.run {
                self.isLoading = false
            }
        }
        
    }
   

}

    /*
#Preview {
    CatViewModel()
}
*/
