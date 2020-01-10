//
//  LastfmService.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//


import Foundation
import UIKit

typealias AlbumHandler = ([Album]) -> Void
typealias TrackHandler = ([Track]) -> Void
typealias ArtistHandler = ([Artist]) -> Void
typealias ArtistInfoHandler = (Artist) -> Void
typealias TrackInfoHandler = (Track) -> Void
typealias AlbumInfoHandler = (Album) -> Void


let lastfm = LastfmService.shared

final class LastfmService
{
    static let shared = LastfmService() //static keyword makes it globall accessible
    
    private init(){}
    //escaping will wait for finish of function even AFTER the function has returned
    func getAlbums(search: String, completion: @escaping AlbumHandler)
    {
  
        var albums = [Album]()

      //First let us query for albums
        guard let albumUrl = LastfmAPI(.albumSearch, search).searchUrl else {
            completion([])
            return }
        
        URLSession.shared.dataTask(with: albumUrl) { (dat, _, err) in
            DispatchQueue.main.async {
                
            
                
            
                if let _ = err{
                    completion([])
                    return
                }
                
                if let data = dat{
                    do{
                       let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>

                        guard let results = jsonResp["results"] else {
                            return }
                        
                        
                        guard let albumMatches = results["albummatches"] as? [String:Any] else {return }
                        
                        guard let albumResults = albumMatches["album"] as? [[String:Any]] else {return}
                        
                        for element in albumResults{
                            guard let name = element["name"] as? String, let albumLink = element["url"] as? String, let artist = element["artist"] as? String, let images = element["image"] as? [[String:Any]] else {return}
                            
                             var image = ""
                            
                            if let mediumImage = images[2] as? [String:String], let imgUrl = mediumImage["#text"]
                            {
                                image = imgUrl
                            }
                            
                            let album = Album(albumName: name, artistName: artist, albumImage: image, albumUrl: albumLink)
                            albums.append(album)
                        }
                        
                      
                    }catch{
                        print("COULD NOT SERIALIZE JSON: \(error.localizedDescription)")
                        completion([])
                        return
                    }
            
                }
                
                completion(albums)
            }
        }.resume()

    }
    
    func getTracks(search: String, completion: @escaping TrackHandler)
    {

        var tracks = [Track]()

        //First let us query for albums
        guard let trackUrl = LastfmAPI(.trackSearch, search).searchUrl else {
          completion([])
          return }

        URLSession.shared.dataTask(with: trackUrl) { (dat, _, err) in
          DispatchQueue.main.async {

              if let _ = err{
                  completion([])
                  return
              }
              
               if let data = dat{
                                 do{
                                    let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>

                                     guard let items = jsonResp["results"] else {
                                         return }
                                     
                                     
                                     guard let trackMatches = items["trackmatches"] as? [String:Any] else {return }
                                     
                                     guard let trackResults = trackMatches["track"] as? [[String:Any]] else {return}
                                     
                                     for element in trackResults{
                                          guard let name = element["name"] as? String, let trackLink = element["url"] as? String, let artist = element["artist"] as? String, let images = element["image"] as? [[String:Any]],let mediumImage = images[2] as? [String:String], let image = mediumImage["#text"] else {return}

                                        let track = Track(trackName: name, artistName: artist, trackImage: image, trackUrl: trackLink)
                                        
                                        tracks.append(track)

                      }
                      
                    
                  }catch{
                      print("COULD NOT SERIALIZE JSON: \(error.localizedDescription)")
                      completion([])
                      return
                  }
          
              }
              
              completion(tracks)
          }
        }.resume()

    }
    
    func getArtists(search: String, completion: @escaping ArtistHandler)
    {

        var artists = [Artist]()
        //First let us query for albums
        guard let artistUrl = LastfmAPI(.artistSearch, search).searchUrl else {
          completion([])
          return }

        URLSession.shared.dataTask(with: artistUrl) { (dat, _, err) in
          DispatchQueue.main.async {

              if let _ = err{
                  completion([])
                  return
              }
              
               if let data = dat{
               do{
                  let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>

                   guard let items = jsonResp["results"] else {
                       return }
                   
                   
                   guard let artistMatches = items["artistmatches"] as? [String:Any] else {return }
                   
                   guard let artistResults = artistMatches["artist"] as? [[String:Any]] else {return}
                   
                   for element in artistResults{
                       guard let name = element["name"] as? String, let artistLink = element["url"] as? String, let images = element["image"] as? [[String:Any]], let mediumImage = images[2] as? [String:String], let image = mediumImage["#text"] else {return}
                                              
                    let artist = Artist(artistName: name, image: image, artistUrl: artistLink)
                       
                       artists.append(artist)

                      }
                      
                  }catch{
                      print("COULD NOT SERIALIZE JSON: \(error.localizedDescription)")
                      completion([])
                      return
                  }
          
              }
              
              completion(artists)
          }
        }.resume()

    }
 
    
}
