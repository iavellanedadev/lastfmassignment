//
//  Item.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

struct Item {
    let title: String
    let data : [Any]

    var numberOfItems: Int {
        return data.count
    }

  
}

extension Item {
    //  Putting a new init method here means we can
    //  keep the original, memberwise initaliser.
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}
