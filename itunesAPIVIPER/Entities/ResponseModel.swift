//
//  ResponseModel.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit


/// Model for itunes response, that is a result count and an array of entities
struct ResponseModel: Decodable {
    let resultCount:Int
    let results:[ArtistModel]
}
