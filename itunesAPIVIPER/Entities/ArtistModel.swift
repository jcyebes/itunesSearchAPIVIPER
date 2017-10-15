//
//  ArtistModel.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

struct ArtistModel: Decodable {
    let artistId: Int
    let artistName:String
    let primaryGenreName:String?
    var discography:[DiscographyItemModel]?
}
