//
//  ArtistListWireFrame.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistListWireFrame: ArtistListWireFrameProtocol {

    class func createArtistListModule() -> UIViewController {
        
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ArtistsNavigationController")
        if let view = navController.childViewControllers.first as? ArtistListView {
            
            // Get components
            let presenter: ArtistListPresenterProtocol & ArtistListInteractorOutputProtocol = ArtistListPresenter()
            let interactor: ArtistListInteractorInputProtocol & ArtistListRemoteDataManagerOutputProtocol = ArtistListInteractor()
            let remoteDataManager: ArtistListRemoteDataManagerInputProtocol = ArtistRemoteDataManager()
            let wireFrame: ArtistListWireFrameProtocol = ArtistListWireFrame()
            
            // Inyect the VIPER Stack
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.requestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    // MARK: Navigation
    func presentDiscographyScreen(from view: ArtistListViewProtocol, forArtist artist: ArtistModel) {
        
    }
    
    // MARK: Private
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
