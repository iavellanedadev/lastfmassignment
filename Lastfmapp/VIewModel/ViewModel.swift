//
//  ViewModel.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation


protocol ViewModelDelegate: class
{
    func update()
}


enum Type: String{
    case artist = "artist"
    case album = "album"
    case track = "track"
}

class ViewModel
{

    weak var delegate: ViewModelDelegate?
    
    var albums = [Album]()
    {
        didSet{
            delegate?.update()
        }
    }

    var tracks = [Track]()
    {
        didSet{
            delegate?.update()
            }
    }

    var artists = [Artist]()
    {
        didSet{
            delegate?.update()
        }
    }
    
    var type: Type!
    
    
    
    var currentAlbum: Album!
//Xico
    
    var currentArtist: Artist!
//    {
//        didSet{
//            getInfo(search: currentArtist.artistName, method:.artist)
//        }
//    }
    
    var currentTrack: Track!
//    {
//        didSet{
//            getInfo(search: currentTrack.trackName, method:.track)
//        }
//    }
   
}

extension ViewModel{

    
    
    func get(_ search: String)
       {
      
            lastfm.getAlbums(search: search) {
                [weak self] albumResult in self?.albums = albumResult
            }

            lastfm.getTracks(search: search){
                [weak self] trackResult in self?.tracks = trackResult

            }
        
            lastfm.getArtists(search: search){
                [weak self] artistResult in self?.artists = artistResult

            }
        }
    
    

}


