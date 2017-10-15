//
//  ArtistListProtocol.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

// MARK: - User Interface

// MARK: Presenter -> View
protocol ArtistListViewProtocol: class {
    var presenter: ArtistListPresenterProtocol? { get set }
    
    func showArtists(with Artists: [ArtistModel])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

// MARK: Presenter -> Wireframe
protocol ArtistListWireFrameProtocol: class {
    static func createArtistListModule() -> UIViewController
    func presentDiscographyScreen(from view: ArtistListViewProtocol, forArtist artist: ArtistModel)
}

// MARK: View -> Presenter
protocol ArtistListPresenterProtocol: class {
    var view: ArtistListViewProtocol? { get set }
    var interactor: ArtistListInteractorInputProtocol? { get set }
    var wireFrame: ArtistListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func retrieveArtistList(forSearchTerm searchTerm:String)
    func showArtistDiscography(forArtist artist: ArtistModel)
}

// MARK:  Interactor -> Presenter
protocol ArtistListInteractorOutputProtocol: class {

    func didRetrieveArtists(_ artists: [ArtistModel])
    func onError()
}

// MARK: - Application Logic

// MARK:  Presenter -> Interactor
protocol ArtistListInteractorInputProtocol: class {
    var presenter: ArtistListInteractorOutputProtocol? { get set }
    var remoteDataManager: ArtistListRemoteDataManagerInputProtocol? { get set }
    
    func retrieveArtistList(forSearchTerm searchTerm:String)
}

// MARK:  Interactor -> Datamanager
protocol ArtistListDataManagerInputProtocol: class {
    
}

// MARK:  Interactor -> RemoteDatamanager
protocol ArtistListRemoteDataManagerInputProtocol: class {
    var requestHandler: ArtistListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveArtistList(forSearchTerm searchTerm:String)
}

// MARK:  RemoteDatamanager -> Interactor
protocol ArtistListRemoteDataManagerOutputProtocol: class {
    
    func onArtistsRetrieved(_ artists: [ArtistModel])
    func onError()
}


