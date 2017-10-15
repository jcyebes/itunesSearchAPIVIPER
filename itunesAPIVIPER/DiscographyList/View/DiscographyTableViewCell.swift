//
//  DiscographyTableViewCell.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 15/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyTableViewCell: UITableViewCell {

    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var albumYearLabel: UILabel!
    
    func set(discographyItemData itemData:DiscographyItemModel) {
        self.albumTitleLabel.text = itemData.title
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: itemData.releaseDate!)
        
        self.albumYearLabel.text = String(year)
    }
    
}
