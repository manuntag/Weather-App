//
//  ForecastService.swift
//  WeatherApp
//
//  Created by David Manuntag on 2016-01-27.
//  Copyright © 2016 David Manuntag. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init (APIKey: String) {
        
        self.forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(self.forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather?->Void)){
        
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
            
        
         print(forecastURL)
            
         let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL {
             
                (let JSONDictionary) in
                
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
                
            }
            
            
        } else {
          
            print("could not construct vaild URL")
            
        }
        
    }
    
    func currentWeatherFromJSON(jsonDictionary: [String:AnyObject]?) -> CurrentWeather?{
      
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String:AnyObject] {
          
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
            
            
        }else {
            
            print("JSON Dictionary returned nil for currently key ")
            
            return nil
        }
        
        
    }
    
    
}
