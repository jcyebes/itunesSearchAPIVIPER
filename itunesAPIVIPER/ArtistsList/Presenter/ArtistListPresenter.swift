//
//  ArtistListPresenter.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistListPresenter: ArtistListPresenterProtocol {

    var view: ArtistListViewProtocol?
    var interactor: ArtistListInteractorInputProtocol?
    var wireFrame: ArtistListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        
    }
    
    func retrieveArtistList(forSearchTerm searchTerm:String) {
        interactor?.retrieveArtistList(forSearchTerm: searchTerm)
    }
    
    func showArtistDetail(forArtist artist: ArtistModel) {
        
    }
}

// Process response from ArtistListInteractor
extension ArtistListPresenter: ArtistListInteractorOutputProtocol {
    
    func didRetrieveArtists(_ artists: [ArtistModel]) {
        view?.hideLoading()
        view?.showArtists(with: artists)
    }
    
    func onError() {
            view?.hideLoading()
            view?.showError()
    }
}

