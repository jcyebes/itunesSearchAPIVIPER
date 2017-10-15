//
//  DiscographyListInteractor.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyListInteractor: DiscographyListInteractorInputProtocol {

    var presenter: DiscographyListInteractorOutputProtocol?
    var remoteDataManager: DiscographyListRemoteDataManagerInputProtocol?
    
    func retrieveDiscographyList(forArtistId artistId:Int) {
        self.remoteDataManager?.retrieveDiscographyList(forArtistId: artistId, limit: nil)
    }
    
}


extension DiscographyListInteractor: DiscographyListRemoteDataManagerOutputProtocol {

    func onDiscographyRetrieved(_ discography: [DiscographyItemModel]) {
           presenter?.didRetrieveDiscography(discography)
    }
    
    func onDiscographyError() {
        presenter?.onError()
    }
}
