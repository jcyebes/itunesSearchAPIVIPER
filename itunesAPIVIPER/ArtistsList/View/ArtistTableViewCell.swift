//
//  ArtistTableViewCell.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    func set(artistData artist:ArtistModel) {
        self.artistNameLabel.text = artist.artistName
        self.genreLabel.text = artist.primaryGenreName
    }
}
