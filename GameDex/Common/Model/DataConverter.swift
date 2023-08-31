//
//  DataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

enum DataConverter {
    // from API "RemotePlatform" to Platform
    static func convert(remotePlatforms: [PlatformData]) -> [Platform] {
        return remotePlatforms.map { remotePlatform in
            let name = remotePlatform.name
            let id = remotePlatform.id
            return Platform(
                title: name,
                id: id
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
                image: remoteGame.image.mediumURL
            )
        }
    }
}
