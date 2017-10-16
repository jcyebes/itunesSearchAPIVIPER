//
//  ArtistListView.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

struct ArtistViewConstants {
    static let artistHeaderHeight:CGFloat = 60.0
    static let artistDiscographyCellHeight:CGFloat = 120.0
    static let artistFooterHeight:CGFloat = 44.0
}

class ArtistListView: UIViewController {

    var presenter: ArtistListPresenterProtocol?
    var artistList: [ArtistModel] = []
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    
    @IBAction func searchArtistAction(_ sender: Any) {
        
        self.searchArtist()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchTextField.addTarget(self, action: #selector(searchArtist), for: .editingDidEndOnExit)

    }
    
    @objc func searchArtist(){
        searchTextField.resignFirstResponder()
        
        if let searchText = self.searchTextField.text {
            presenter?.retrieveArtistList(forSearchTerm: searchText)
        }
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
        let alertController = UIAlertController(title: "Error", message: "There are no results for your search", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
       
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
             self.activityIndicator.stopAnimating()
        }
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
        return ArtistViewConstants.artistHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        // Use a cell view as header
        let artist = self.artistList[section]
        if artist.discography != nil {
            let  artistFooter = tableView.dequeueReusableCell(withIdentifier: "ArtistFooterView")
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFooterTap))
            artistFooter!.addGestureRecognizer(tapRecognizer)
            
            return artistFooter
        } else {
            return nil
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let artist = self.artistList[section]
        if artist.discography != nil {
             return ArtistViewConstants.artistFooterHeight
        } else {
            return 0
        }
       
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
        return ArtistViewConstants.artistDiscographyCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let partialDiscography = self.artistList[section].discography {
            return partialDiscography.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = self.artistList[indexPath.section]
        presenter?.showArtistDiscography(forArtist: artist)
    }
    
    // Private: handle tap on footer
    @objc func handleFooterTap(sender: UITapGestureRecognizer) {
        var tapLocation = sender.location(in: self.tableView)
        tapLocation.y -= ArtistViewConstants.artistFooterHeight // A little trick
        if let indexPath = self.tableView.indexPathForRow(at: tapLocation) {
            let artist = self.artistList[indexPath.section]
            presenter?.showArtistDiscography(forArtist: artist)
        }
    }
    
}

