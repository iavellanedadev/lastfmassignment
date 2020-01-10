//
//  ArtistTableViewCell.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var artistImage: UIImageView!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    static let identifier = "ArtistTableViewCell"
    
    var artist: Artist!
    {
        didSet{
            artistLabel.text = artist.artistName
            
            DispatchQueue.global(qos: .background).async {
                guard let url = URL(string: self.artist.image) else {return}
                
              var data = Data()
                
                do{
                    data = try Data(contentsOf: url)
                    
                    
                }catch{
                    print("ERROR FOUND GETTING IMAGE: " + error.localizedDescription)
                }

                
                guard let image = UIImage(data: data) else {return }
                
                DispatchQueue.main.async {
                    self.artistImage.image = image
                }
            }
        }
    }

}
