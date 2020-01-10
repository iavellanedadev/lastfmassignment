//
//  LastfmAPI.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation


enum ApiMethod: String {
    case artistSearch = "?method=artist.search&artist="
    case albumSearch = "?method=album.search&album="
    case trackSearch = "?method=track.search&track="
    case artistInfo = "?method=artist.getInfo&artist="
    case albumInfo = "?method=album.getInfo&album="
    case trackInfo = "?method=track.getInfo&track="
}

struct LastfmAPI
{
    let base = "http://ws.audioscrobbler.com/2.0/"
    
    let key = "&api_key=9f784c6881aa387e833a59239c5d13f3"
    
    let method: ApiMethod!
    
    let search: String?
        
    let addtl: String?
    
    init(_ method: ApiMethod, _ search: String? = nil, addtl: String? = nil)
       {
            self.method = method
            self.search = search
            self.addtl = addtl
        
       }
       
    var searchUrl: URL? {
        guard let s = search else {return nil}
        
        var urlString = ""
        
        if let additional = addtl
        {
            
            let params = s + "&artist=\(additional)"
            
            guard let encodedParams = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return nil}

            urlString = base + method!.rawValue + encodedParams + key + "&format=json"
            
            
        }else
        {
            urlString = base + method!.rawValue + s + key + "&format=json"
        }
        let url = URL(string: urlString )
        
        return url
    }
    
    
}
