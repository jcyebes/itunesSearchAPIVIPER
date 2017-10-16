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
    
    private var artistName: String = ""
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension DiscographyListView: DiscographyListViewProtocol {
    
    func showDiscography(with discography: [DiscographyItemModel]) {
        self.discography = discography
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setArtistName(artistName: String) {
        self.artistName = artistName
    }
    
    func showError() {
        
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
extension DiscographyListView: UITableViewDataSource, UITableViewDelegate {
    
    // Section Header
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Use a cell view as header
        let artistHeader = tableView.dequeueReusableCell(withIdentifier: "DiscographyHeaderView") as! DiscographyArtistHeaderCell
        artistHeader.set(artistData: self.artistName)
        
        return artistHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44.0
    }
    
    // Album cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscographyCell", for: indexPath) as! DiscographyTableViewCell
        
        let discographyItem = self.discography[indexPath.row]
        cell.set(discographyItemData: discographyItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discography.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
