//
//  DiscographyListPresenter.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyListPresenter: DiscographyListPresenterProtocol {

    var view: DiscographyListViewProtocol?
    var interactor: DiscographyListInteractorInputProtocol?
    var wireFrame: DiscographyListWireFrameProtocol?
    
    var artist: ArtistModel?
    
    func viewDidLoad() {
        view?.showLoading()
        
        if let artistToLoad = self.artist {
            
             view?.setArtistName(artistName: artistToLoad.artistName)
            
             print ("Trying to show discography for artist \(artistToLoad.artistName)")
             interactor?.retrieveDiscographyList(forArtistId: artistToLoad.artistId)
        }
    }
    
}

extension DiscographyListPresenter: DiscographyListInteractorOutputProtocol {
    
    func didRetrieveDiscography(_ discography: [DiscographyItemModel]) {
        view?.hideLoading()
        
        // Order discography by releaseDate descending
        let orderedDiscography =  discography.sorted(by: { $0.releaseDate?.compare($1.releaseDate!) == ComparisonResult.orderedDescending })
        
        view?.showDiscography(with: orderedDiscography)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
