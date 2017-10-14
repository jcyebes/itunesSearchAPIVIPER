//
//  DiscographyListProtocol.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

protocol DiscographyListViewProtocol: class {
    var presenter: DiscographyListPresenterProtocol? { get set }
    
    func showDiscographys(with Discographys: [DiscographyItemModel])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

// MARK: Presenter -> Wireframe
protocol DiscographyListWireFrameProtocol: class {
    static func createDiscographyListModule() -> UIViewController
    
}

// MARK: View -> Presenter
protocol DiscographyListPresenterProtocol: class {
    var view: DiscographyListViewProtocol? { get set }
    var interactor: DiscographyListInteractorInputProtocol? { get set }
    var wireFrame: DiscographyListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func retrieveDiscographyList(forArtistId artistId:String)
}

// MARK:  Interactor -> Presenter
protocol DiscographyListInteractorOutputProtocol: class {
    
    func didRetrieveDiscography(_ discography: [DiscographyItemModel])
    func onError()
}


// MARK:  Presenter -> Interactor
protocol DiscographyListInteractorInputProtocol: class {
    var presenter: DiscographyListInteractorOutputProtocol? { get set }
    var remoteDataManager: DiscographyListRemoteDataManagerInputProtocol? { get set }
    
    func retrieveDiscographyList(forArtistId artistId:String)
}

// MARK:  Interactor -> Datamanager
protocol DiscographyListDataManagerInputProtocol: class {
    
}

// MARK:  Interactor -> RemoteDatamanager
protocol DiscographyListRemoteDataManagerInputProtocol: class {
    var requestHandler: DiscographyListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveDiscographyList(forArtistId artistId:String)
}

// MARK:  RemoteDatamanager -> Interactor
protocol DiscographyListRemoteDataManagerOutputProtocol: class {
    
    func onDiscographyRetrieved(_ discography: [DiscographyItemModel])
    func onError()
}