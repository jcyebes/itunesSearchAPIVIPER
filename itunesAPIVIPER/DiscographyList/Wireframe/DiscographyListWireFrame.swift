//
//  DiscographyListWireFrame.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyListWireFrame: DiscographyListWireFrameProtocol {
    
    class func createDiscographyListModule(for artist:ArtistModel) -> UIViewController {
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DiscographyViewController")
        if let view = viewController as? DiscographyListView {
            
            // Get components
            let presenter: DiscographyListPresenterProtocol & DiscographyListInteractorOutputProtocol = DiscographyListPresenter()
            let interactor: DiscographyListInteractorInputProtocol & DiscographyListRemoteDataManagerOutputProtocol = DiscographyListInteractor()
            let remoteDataManager: DiscographyListRemoteDataManagerInputProtocol = DiscographyRemoteDataManager()
            let wireFrame: DiscographyListWireFrameProtocol = DiscographyListWireFrame()
            
            // Inyect the VIPER Stack
            view.presenter = presenter
            presenter.artist = artist
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.requestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    // MARK: Private
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

}
