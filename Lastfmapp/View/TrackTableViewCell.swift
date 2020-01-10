//
//  TrackTableViewCell.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackLabel: UILabel!
    
    
    @IBOutlet weak var trackArtistLabel: UILabel!
    
    static let identifier = "TrackTableViewCell"

    var track: Track!
    {
        didSet{
            trackLabel.text = track.trackName
            trackArtistLabel.text = track.artistName
        }
    }
}
