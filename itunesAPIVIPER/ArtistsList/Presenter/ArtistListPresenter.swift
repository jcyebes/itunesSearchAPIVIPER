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
        
        if searchTerm.isEmpty {
            view?.showError()
            return
        }
        
        interactor?.retrieveArtistList(forSearchTerm: searchTerm)
    }
    
    func showArtistDiscography(forArtist artist: ArtistModel) {
        wireFrame?.presentDiscographyScreen(from: view!, forArtist: artist)
    }
}

// Process response from ArtistListInteractor
extension ArtistListPresenter: ArtistListInteractorOutputProtocol {
    
    func didRetrieveArtists(_ artists: [ArtistModel]) {
        view?.hideLoading()
        
        if (artists.count > 0) {
            view?.showArtists(with: artists)
        } else {
            view?.showError()
        }
        
    }
    
    func didRetrieveDiscography(_ discography: [DiscographyItemModel]) {
        view?.updateArtist(with: discography)
    }
    
    func onError() {
            view?.hideLoading()
            view?.showError()
    }
}

