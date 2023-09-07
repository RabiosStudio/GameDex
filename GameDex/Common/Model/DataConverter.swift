//
//  DataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

enum DataConverter {
    static func convert(remotePlatforms: [PlatformData]) -> [Platform] {
        return remotePlatforms.map { remotePlatform in
            return Platform(
                title: remotePlatform.name,
                id: remotePlatform.id
            )
        }
    }
    
    static func convert(remoteGames: [GameData], platform: Platform) -> [Game] {
        return remoteGames.map { remoteGame in
            return Game(
                title: remoteGame.name,
                description: remoteGame.deck,
                id: remoteGame.guid,
                platform: platform.title,
                imageURL: remoteGame.image.mediumURL
            )
        }
    }
}
