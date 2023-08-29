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
            return Platform(
                title: remotePlatform.platformName,
                id: remotePlatform.platformID
            )
        }
    }
}
