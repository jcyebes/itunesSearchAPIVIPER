//
//  DiscographyItemModel.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

struct DiscographyItemModel: Codable {
    
    var coverImageUrl: URL
    var title: String
    var year: String
    
    // implement codable
    init?(json: [String: Any]) {
        guard let coverImageUrlString = json["artworkUrl60"] as? String,
            let title = json["collectionName"] as? String,
            let releaseDate = json["primaryGenreName"] as? Date
            else {
                return nil
        }
        
        self.coverImageUrl = URL(string: coverImageUrlString)!
        self.title = title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let releaseYear = dateFormatter.string(from: releaseDate)
        self.year = releaseYear
    }
    
}
