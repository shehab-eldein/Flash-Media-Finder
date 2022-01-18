//
//  NetworkingManager.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 23/11/2021.
//

import Foundation
import Alamofire

struct NetworkingManager {
    
    static  func getMedia (search: String,media: String,spinner: UIActivityIndicatorView , completion: @escaping(_ error: Error?, _ mediaArr: [Media]?) -> Void) {
        
        let parameter = [NetWorking.searchaKey: search, NetWorking.mediaKey: media]
        AF.request(NetWorking.url, method: .get, parameters: parameter , encoding: URLEncoding.default, headers: nil).response {
            response in
            if let erorr = response.error {
                completion(erorr,nil)
            }
            if let data = response.data {
                do {
                    let mediaArr = try JSONDecoder().decode(MediaRespone.self, from:data ).results
                    completion(nil,mediaArr)
                    spinner.isHidden = true
                } catch {
                    print("EROR from the data:\(error)")
                }
            }
        }
    }
    
    
}
