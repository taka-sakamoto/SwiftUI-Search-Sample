//
//  FavoriteViewModel.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/06.
//

import Foundation
import CoreData
import Combine

class FavoriteViewModel: ObservableObject {
    
    let context: NSManagedObjectContext
    @Published var favorites: [FavoriteCat] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchFavorites()
    }
    
    // お気に入り取得
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteCat> = FavoriteCat.fetchRequest()
        
        do {
            favorites = try context.fetch(request)
        } catch {
            print("取得エラー: \(error)")
        }
    }
    
    // お気に入り判定
    func isFavorite(cat: Cat) -> Bool {
        favorites.contains { $0.id == cat.id }
    }
    
    // 保存処理
    func addFavorite(cat: Cat) {
        let favorite = FavoriteCat(context: context)
        favorite.id = cat.id
        //favorite.name = cat.id
        favorite.imageUrl = cat.url
        
        save()
    }
    
    // 削除処理
    func removeFavorite(cat: Cat) {
        if let target = favorites.first(where: { $0.id == cat.id}) {
            context.delete(target)
            save()
        }
    }
    
    private func save() {
        do {
            try context.save()
            fetchFavorites()
        } catch {
            print("保存エラー: \(error)")
        }
    }
}
