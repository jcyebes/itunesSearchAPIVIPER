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
    var artistRemoteDataManager: ArtistListRemoteDataManagerInputProtocol?
    var discRemoteDataManager: DiscographyListRemoteDataManagerInputProtocol?
    
    func retrieveArtistList(forSearchTerm searchTerm:String) {
        artistRemoteDataManager?.retrieveArtistList(forSearchTerm: searchTerm)
    }
    
}


// Process RemoteData manager Async response
extension ArtistListInteractor: ArtistListRemoteDataManagerOutputProtocol {
    
    func onArtistsRetrieved(_ artists: [ArtistModel]) {
        
        // Update UI, while discography response is retrieved
        presenter?.didRetrieveArtists(artists)
        
        // Get partial discography for each artist
        for artist in artists {
           discRemoteDataManager?.retrieveDiscographyList(forArtistId: artist.artistId, limit: 2)
        }
    }
    
    
    func onArtistError() {
        presenter?.onError()
    }
    
}


extension ArtistListInteractor: DiscographyListRemoteDataManagerOutputProtocol {
    
    func onDiscographyRetrieved(_ discography: [DiscographyItemModel]) {
        // Update artists with retrieved discography
        presenter?.didRetrieveDiscography(discography)
    }
    
    func onDiscographyError() {
    }
    
}
