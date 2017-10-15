//
//  DiscographyListView.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyListView: UIViewController {
    
    var presenter: DiscographyListPresenterProtocol?
    var discography: [DiscographyItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension DiscographyListView: DiscographyListViewProtocol {
    
    func showDiscography(with discography: [DiscographyItemModel]) {
        self.discography = discography

    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
