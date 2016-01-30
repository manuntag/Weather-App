//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Manuntag on 2016-01-14.
//  Copyright © 2016 David Manuntag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var chanceOfPrecipLabel: UILabel!
    
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshButtonView: UIButton!
    
    
    private let apiKey = "0df75dc5437e56952c5ca8da388bf1d0"
    
    let coordinate: (lat:Double, long:Double) = (49.2500,-123.1333)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
   retrieveWeatherForecast()
        
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshWeather(sender: AnyObject) {
        
        toggleRefreshAnimation(true)
        
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on:Bool){
        
        refreshButtonView.hidden = on
        
        if on {
          
            activityIndicator.startAnimating()
            
        }else {
            activityIndicator.stopAnimating()
        
        }
        
    }

    func retrieveWeatherForecast(){
        
        
        let forecastService = ForecastService(APIKey: apiKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            
            (let currently) in
            
            if let currentWeather = currently {
                
                // update UI
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        
                        self.currentTemperatureLabel.text = " \(temperature)º"
                        
                    }
                    
                    if let humidity = currentWeather.humidity {
                        
                        self.humidityLabel.text = "\(humidity)%"
                        
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        
                        self.chanceOfPrecipLabel.text = "\(precipitation)%"
                        
                    }
                    
                    
                    if let icon = currentWeather.icon {
                        
                        self.currentWeatherIcon.image = icon
                        
                    }
                    
                    if let summary = currentWeather.summary {
                        
                        self.summaryLabel.text = summary
                    }
                    
                self.toggleRefreshAnimation(false)
                
                
                }
                
            }
            
            
        }
        
        
    }
    
}

