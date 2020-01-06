//
//  secondTabView.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/27/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON
import Charts

class secondTabView: UIView {

    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!

    @IBOutlet weak var weeklyImage: UIImageView!
    

    func setSecondTabView(json:JSON){
        topButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        topButton.layer.borderWidth = 1.0
        topButton.layer.borderColor = UIColor.white.cgColor
        topButton.layer.cornerRadius = 20
       
        summLabel.text = json["daily"]["summary"].stringValue
        summLabel.numberOfLines = 2
        summLabel.numberOfLines = Int(summLabel.text!.count/14) + 1
        summLabel.font = UIFont.boldSystemFont(ofSize: 20.0)

        
        if(json["daily"]["icon"].stringValue == "clear-day"){
            weeklyImage.image = UIImage(named: "weather-sunny")
        }
        else if(json["daily"]["icon"].stringValue == "clear-night"){
            weeklyImage.image = UIImage(named: "weather-night")
        }
        else if(json["daily"]["icon"].stringValue == "rain"){
            weeklyImage.image = UIImage(named: "weather-rainy")
        }
        else if(json["daily"]["icon"].stringValue == "snow"){
            weeklyImage.image = UIImage(named: "weather-snowy")
        }
        else if(json["daily"]["icon"].stringValue == "sleet"){
            weeklyImage.image = UIImage(named: "weather-snowy-rainy")
        }
        else if(json["daily"]["icon"].stringValue == "wind"){
            weeklyImage.image = UIImage(named: "weather-windy-variant")
        }
        else if(json["daily"]["icon"].stringValue == "fog"){
            weeklyImage.image = UIImage(named: "weather-fog")
        }
        else if(json["daily"]["icon"].stringValue == "cloudy"){
            weeklyImage.image = UIImage(named: "weather-cloudy")
        }
        else if(json["daily"]["icon"].stringValue == "partly-cloudy-night"){
            weeklyImage.image = UIImage(named: "weather-night-partly-cloudy")
        }
        else if(json["daily"]["icon"].stringValue == "partly-cloudy-day"){
            weeklyImage.image = UIImage(named: "weather-partly-cloudy")
        }
        else{
            weeklyImage.image = UIImage(named: "weather-sunny")
        }
        chart.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        var chartData = [ChartDataEntry]()
        var chartDataHigh = [ChartDataEntry]()
        
        for i in 0..<8{
            chartData.append(ChartDataEntry(x: Double(i), y: round(json["daily"]["data"][i]["temperatureLow"].double!)))
            chartDataHigh.append(ChartDataEntry(x: Double(i), y: round(json["daily"]["data"][i]["temperatureHigh"].double!)))
        }
        
        
        
        let line = LineChartDataSet(entries: chartData, label:"Minimum Temperature (ºF)")
        line.colors = [NSUIColor.white]
        line.circleColors = [NSUIColor.white]
        line.circleHoleRadius = 0
        line.circleRadius = 5
        let line2 = LineChartDataSet(entries: chartDataHigh, label:"Maximum Temperature (ºF)")
        line2.colors = [NSUIColor.orange]
        line2.circleColors = [NSUIColor.orange]
        line2.circleHoleRadius = 0
        line2.circleRadius = 5
        
        let data = LineChartData()
        data.addDataSet(line)
        data.addDataSet(line2)
        chart.data = data
        
    }
    
    
    
    

}
