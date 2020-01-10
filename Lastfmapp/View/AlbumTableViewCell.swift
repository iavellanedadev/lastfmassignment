//
//  TableViewCell.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    static let identifier = "AlbumTableViewCell"

    var album: Album! {
           didSet{
                albumLabel.text = album.albumName
                artistLabel.text = album.artistName
                DispatchQueue.main.async {
                guard let url = URL(string: self.album.albumImage) else {return}
                
                var data = Data()

                do{
                data = try Data(contentsOf: url)


                }catch{
                    print("ERROR FOUND GETTING IMAGE: " + error.localizedDescription)
                }


                guard let image = UIImage(data: data) else {return }


                self.imageLabel.image = image
            }
            
               
           }
       }
    
    
    
    
}
