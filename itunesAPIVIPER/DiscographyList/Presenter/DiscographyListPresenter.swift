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
    
    func viewDidLoad() {
        view?.showLoading()
    }
    
    func retrieveDiscographyList(forArtistId artistId:String) {
        interactor?.retrieveDiscographyList(forArtistId: artistId)
    }
    
}

extension DiscographyListPresenter: DiscographyListInteractorOutputProtocol {
    
    func didRetrieveDiscography(_ discography: [DiscographyItemModel]) {
        view?.showDiscography(with: discography)
    }
    
    func onError() {
        view?.showError()
    }
}
