//
//  ArtistListInteractor.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistListInteractor: ArtistListInteractorInputProtocol {
    
    weak var presenter: ArtistListInteractorOutputProtocol?
    var remoteDataManager: ArtistListRemoteDataManagerInputProtocol?
    
    func retrieveArtistList(forSearchTerm searchTerm:String) {
        remoteDataManager?.retrieveArtistList(forSearchTerm: searchTerm)
    }
    
}


// Process RemoteData manager Async response
extension ArtistListInteractor: ArtistListRemoteDataManagerOutputProtocol {
    
    func onArtistsRetrieved(_ artists: [ArtistModel]) {
        presenter?.didRetrieveArtists(artists)
    }
    
    
    func onError() {
        presenter?.onError()
    }
    
}
