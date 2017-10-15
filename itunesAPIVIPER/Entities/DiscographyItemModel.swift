//
//  DiscographyItemModel.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit


struct DiscographyItemModel: Decodable {
    
    enum discographyKeys: String, CodingKey {
        case artworkUrl100 = "artworkUrl100"
        case collectionName = "collectionName"
        case releaseDate = "releaseDate"
        case wrapperType = "wrapperType"
        case artistId = "artistId"
    }
    
    let coverImageUrl: URL?
    let title: String?
    let releaseDate: Date?
    let artistId: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: discographyKeys.self)
        
        let wrapperType: String = try container.decode(String.self, forKey: .wrapperType)
        if wrapperType == "collection" {
            let coverImageUrl: URL = try container.decode(URL.self, forKey: .artworkUrl100)
            let titleString: String = try container.decode(String.self, forKey: .collectionName)
            let releaseDate: Date = try container.decode(Date.self, forKey: .releaseDate)
            let artistId: Int = try container.decode(Int.self, forKey: .artistId)
                
            self.coverImageUrl = coverImageUrl
            self.title = titleString
            self.releaseDate = releaseDate
            self.artistId = artistId
        } else {
                self.coverImageUrl = nil
                self.title = nil
                self.releaseDate = nil
                self.artistId = nil
        }
    }
}
