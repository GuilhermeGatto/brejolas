//
//  APIRequest.swift
//  Brejolas
//
//  Created by Guilherme Gatto on 23/11/19.
//  Copyright © 2019 Guilherme Gatto. All rights reserved.
//

import UIKit

class APIRequest {

    static private let session = URLSession(configuration: .default)
    
    typealias completionHandler = (ResponseEnum<[Beer]>) -> Void
    typealias imageCompletionHandler = (ResponseEnum<UIImage>) -> Void
    
    static func getData(completion: @escaping (completionHandler)){
        
        let endpoint = self.endPoint(url: APISupport.baseURL)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)){ data, _ , error in
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode([Beer].self, from: data!)
                completion(ResponseEnum.success(response))
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }
    
    static func downloadImage(url: String, completion: @escaping (imageCompletionHandler)){
        
        let endpoint = self.endPoint(url: url)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { (data, _, error) in
            
            if error != nil {
                completion(ResponseEnum.error(error!.localizedDescription))
            }else{
                let image = UIImage(data: data!)
                
                if let image = image {
                    completion(ResponseEnum.success(image))
                }else{
                    completion(ResponseEnum.success(UIImage(named: "notfound")!))
                }
            }
        }
        task.resume()
    }
 
    static private func endPoint(url: String) -> URL{
        guard let baseUrl = URL(string: url) else {
            return URL(fileURLWithPath: "")
        }
        return baseUrl
    }
    
}
