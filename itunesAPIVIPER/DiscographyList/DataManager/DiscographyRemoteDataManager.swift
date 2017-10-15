//
//  DiscographyRemoteDataManager.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class DiscographyRemoteDataManager: DiscographyListRemoteDataManagerInputProtocol {

    var requestHandler: DiscographyListRemoteDataManagerOutputProtocol?
    
    func retrieveDiscographyList(forArtistId artistId:Int, limit numberOfItems: Int?) {
        
        let url = URL(string: self.getDiscographyQuery(artistId: artistId, limit: numberOfItems))
        
        let downloadTask = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("There were an error retrieving data")
                self.requestHandler?.onDiscographyError()
                return
            }
            
            guard let responseData = data else {
                print("No data in response")
                self.requestHandler?.onDiscographyError()
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let discResponseModel = try decoder.decode(DiscographyResponseModel.self, from: responseData)
                var cleanResults:[DiscographyItemModel] = discResponseModel.results
                cleanResults.removeFirst()
                
                self.requestHandler?.onDiscographyRetrieved(cleanResults)
            } catch {
                print("error trying to convert data")
                print(error)
                self.requestHandler?.onDiscographyError()
            }
        }
        
        downloadTask.resume()
        
    }
    
    
    /// Private
    private func getDiscographyQuery(artistId:Int, limit:Int?) -> String {
        
        // TODO: Put host URL and paths in a global structure
        var urlString = "https://itunes.apple.com/lookup?id=\(artistId)&entity=album"
        if let itemLimit = limit {
            urlString = "https://itunes.apple.com/lookup?id=\(artistId)&entity=album&limit=\(itemLimit)"
        }
        return urlString
    }
    
}
