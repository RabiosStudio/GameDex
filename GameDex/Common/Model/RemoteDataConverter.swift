//
//  RemoteDataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

enum RemoteDataConverter {
    // MARK: - Remote data to data
    static func convert(remoteGames: [GameData], platform: Platform) -> [Game] {
        return remoteGames.map { remoteGame in
            return Game(
                title: remoteGame.name,
                description: remoteGame.deck,
                id: remoteGame.guid,
                platformId: platform.id,
                imageURL: remoteGame.image.mediumUrl,
                releaseDate: remoteGame.originalReleaseDate
            )
        }
    }
}
