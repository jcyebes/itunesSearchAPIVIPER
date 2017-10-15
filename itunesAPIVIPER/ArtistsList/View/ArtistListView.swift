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
    var artistList: [ArtistModel] = []
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    
    
    @IBAction func searchArtistAction(_ sender: Any) {
        if let searchText = self.searchTextField.text {
             presenter?.retrieveArtistList(forSearchTerm: searchText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
}


extension ArtistListView: ArtistListViewProtocol {
    
    func showArtists(with artists: [ArtistModel]) {
        artistList = artists
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}

// MARK: TableView delegate
extension ArtistListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        
        let artist = self.artistList[indexPath.row]
        cell.set(artistData: artist)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistList.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let artist = self.artistList[indexPath.row]
        presenter?.showArtistDiscography(forArtist: artist)
    }
    
}

