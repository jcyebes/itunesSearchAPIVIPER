//
//  ArtistRemoteDataManager.swift
//  itunesAPIVIPER
//
//  Created by José Carlos Yebes Torres on 14/10/17.
//  Copyright © 2017 José Carlos Yebes Torres. All rights reserved.
//

import UIKit

class ArtistRemoteDataManager: ArtistListRemoteDataManagerInputProtocol {
    
    var requestHandler: ArtistListRemoteDataManagerOutputProtocol?

    func retrieveArtistList(forSearchTerm searchTerm:String) {
        
        let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: self.getArtistQuery(term: escapedSearchTerm!));
        
        let downloadTask = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("There were an error retrieving data")
                self.requestHandler?.onArtistError()
                return
            }
            
            guard let responseData = data else {
                print("No data in response")
                self.requestHandler?.onArtistError()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseModel = try decoder.decode(ResponseModel.self, from: responseData)
                dump(responseModel)
                self.requestHandler?.onArtistsRetrieved(responseModel.results)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                self.requestHandler?.onArtistError()
            }
        }
        
        downloadTask.resume()
    }
    
    /// Private
    private func getArtistQuery(term:String) -> String {
        
        // Clean terms
        let cleanSearchTermsString = term.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        // TODO: Put host URL and paths in a global structure
        return "https://itunes.apple.com/search?term=\(cleanSearchTermsString)&country=ES&entity=musicArtist"
    }
    
}
