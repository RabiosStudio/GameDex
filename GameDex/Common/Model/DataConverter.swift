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
    
    static func convert(remoteGames: [RemoteGame]) -> [Game] {
        return remoteGames.map { remoteGame in
            var releasedOn: [Platform] = []
            for platform in remoteGame.platforms {
                let name = platform.platformName
                let id = platform.platformID
                let platformToAdd = Platform(title: name, id: id)
                releasedOn.append(platformToAdd)
            }
            return Game(
                title: remoteGame.title,
                description: remoteGame.description ?? "",
                id: remoteGame.gameID,
                genres: remoteGame.genres.first?.genreName,
                url: remoteGame.officialURL,
                platforms: releasedOn,
                image: remoteGame.sampleCover?.image
            )
        }
    }
}
