//
//  DiscographyArtistHeaderCell.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 16/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyArtistHeaderCell: UITableViewCell {
    
    @IBOutlet var artistNameLabel: UILabel!
    
    func set(artistData artistName:String) {
        self.artistNameLabel.text = artistName
    }
}
