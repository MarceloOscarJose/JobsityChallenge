//
//  FavoritesModel.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 28/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import CoreData

class FavoritesModel: NSObject {

    var favorites: [Favorites] = []

    public func fetchFavorites() {
        if let favorites = PersistenceManager.sharedInstance.fetchFavorites(sortBy: "name", ascending: true) {
            self.favorites = favorites
        } else {
            favorites = []
        }
    }

    public func saveFavorite(showData: ShowData) {

        let backgroundContext = PersistenceManager.sharedInstance.persistentContainer.viewContext

        do {
            if let postData = PersistenceManager.sharedInstance.fetchFavoriteById(id: Int64(truncatingIfNeeded: showData.id)) {
                backgroundContext.delete(postData)
            } else {
                let favoriteEntity = Favorites(context: backgroundContext)
                favoriteEntity.id = Int64(truncatingIfNeeded: showData.id)
                favoriteEntity.name = showData.title
                favoriteEntity.image = showData.image ?? ""
                favoriteEntity.rating = showData.rating
                favoriteEntity.genres = showData.genres
                favoriteEntity.didSave()
            }
            try backgroundContext.save()
        } catch {
            print(error)
        }
    }

    public func deleteFavorite(showId: Int64) {
        let backgroundContext = PersistenceManager.sharedInstance.persistentContainer.viewContext

        do {
            if let postData = PersistenceManager.sharedInstance.fetchFavoriteById(id: showId) {
                backgroundContext.delete(postData)
                try backgroundContext.save()
            }
        } catch {
            print(error)
        }
    }
}
