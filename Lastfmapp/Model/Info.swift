//
//  Info.swift
//  Lastfmapp
//
//  Created by Consultant on 1/9/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

struct AlbumInfo
{
    let albumName: String
    let artistName: String
    let url: String
    let summary: String
}

struct TrackInfo
{
    let trackName: String
    let albumName: String
    let artistName: String
    let url: String
    let summary: String
}

struct ArtistInfo
{
    let artistName: String
    let url: String
    let summary: String
    let similarArtists: [String]
}
