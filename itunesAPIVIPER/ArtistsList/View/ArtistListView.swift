//
//  ArtistListView.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistListView: UIViewController {
    
    var presenter: ArtistListPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
}


extension ArtistListView: ArtistListViewProtocol {
    
    func showArtists(with Artists: [ArtistModel]) {
        
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}
