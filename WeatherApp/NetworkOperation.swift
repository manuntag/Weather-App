//
//  NetworkOperation.swift
//  WeatherApp
//
//  Created by David Manuntag on 2016-01-18.
//  Copyright © 2016 David Manuntag. All rights reserved.
//

import Foundation

class NetworkOperation {
    
lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
lazy var session: NSURLSession = NSURLSession(configuration: self.config)
let queryURL :NSURL

    typealias jsonDictionaryCompletion = ([String:AnyObject]?)->Void
    
    init(url: NSURL) {
        
        self.queryURL = url
    
    }

    
    func downloadJSONFromURL(completion: jsonDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            
            (let data, let response, let error) in
            
            // 1. Check HTTP response for sucessful GET request 
            
            if let httpRepsonse = response as? NSHTTPURLResponse {
                
                switch(httpRepsonse.statusCode){
                  
                case 200:
                     // 2. Create JSON object with Data
                
                do {
                
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: [] ) as? [String: AnyObject]
                    
                    completion(jsonDictionary)
                    
                } catch let error{
                    
                    print("\(error)")
                    
                    }
                default:
                    print("Get request not sucessful")
                    
                }
                
                
            }else {
                
              print("error not vaild HTTP response")
            }
            
        
            
        }
        
       dataTask.resume()
        
    }

    
}
