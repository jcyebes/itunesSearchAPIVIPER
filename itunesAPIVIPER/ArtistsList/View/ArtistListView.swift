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
    
    func updateArtist(with discography: [DiscographyItemModel]) {
        
        // Update artists
        let discArtistId = discography.first?.artistId
        if let artistOffset = artistList.index(where: { $0.artistId == discArtistId}) {
           artistList[artistOffset].discography = discography
        }
        
        // Reload table
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
    
    // Artist Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.artistList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Use a cell view as header
        let artistHeader = tableView.dequeueReusableCell(withIdentifier: "ArtistCell") as! ArtistTableViewCell
        
        let artist = self.artistList[section]
        artistHeader.set(artistData: artist)
        
        return artistHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Create a dummy View
        let vw = UIView()
        vw.backgroundColor = UIColor.green
        
        return vw
    }
    
    // Discography cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscographyCell", for: indexPath) as! DiscographyTableViewCell
        
        let discographyItem = self.artistList[indexPath.section].discography![indexPath.row]
        cell.set(discographyItemData: discographyItem)
        
        
        return cell
    }
    
    // Discography cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let partialDiscography = self.artistList[section].discography {
            return partialDiscography.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = self.artistList[indexPath.row]
        presenter?.showArtistDiscography(forArtist: artist)
    }
    
    
    
}

