//
//  firstTabView.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/27/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON



class firstTabView: UIView {
   
    @IBOutlet weak var summImage: UIImageView!
    @IBOutlet weak var ozoneValue: UITextField!
    @IBOutlet weak var cloudValue: UITextField!
    @IBOutlet weak var visibValue: UITextField!
    @IBOutlet weak var humidValue: UITextField!
    
    @IBOutlet var summValue: UILabel!
    @IBOutlet weak var tempValue: UITextField!
    @IBOutlet weak var precValue: UITextField!
    
    @IBOutlet weak var pressValue: UITextField!
    @IBOutlet weak var windValue: UITextField!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button33: UIButton!
    @IBOutlet weak var button32: UIButton!
    
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button23: UIButton!
    
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button31: UIButton!
    
    @IBOutlet weak var button22: UIButton!
    
    @IBOutlet weak var button12: UIButton!
    func setFirstTabView(json:JSON){
        button11.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button11.layer.borderWidth = 1.0
        button11.layer.borderColor = UIColor.white.cgColor
        button11.layer.cornerRadius = 10
        windValue.text = String(json["currently"]["windSpeed"].doubleValue)+" mph"
        windValue.backgroundColor = UIColor.clear
        windValue.borderStyle = .none
        windValue.textAlignment = .center
        windValue.font = .systemFont(ofSize: 20)
        

        
        
        button12.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button12.layer.borderWidth = 1.0
        button12.layer.borderColor = UIColor.white.cgColor
        button12.layer.cornerRadius = 10
        pressValue.text = String(json["currently"]["pressure"].doubleValue)+" mb"
        pressValue.backgroundColor = UIColor.clear
        pressValue.borderStyle = .none
        pressValue.textAlignment = .center
        pressValue.font = .systemFont(ofSize: 20)
        
        
        button13.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button13.layer.borderWidth = 1.0
        button13.layer.borderColor = UIColor.white.cgColor
        button13.layer.cornerRadius = 10
        precValue.text = String(json["currently"]["precipProbability"].doubleValue)+" mmph"
        precValue.backgroundColor = UIColor.clear
        precValue.borderStyle = .none
        precValue.textAlignment = .center
        precValue.font = .systemFont(ofSize: 20)
        
        button21.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button21.layer.borderWidth = 1.0
        button21.layer.borderColor = UIColor.white.cgColor
        button21.layer.cornerRadius = 10
        tempValue.text = String(json["currently"]["temperature"].intValue)+"ºF"
        tempValue.backgroundColor = UIColor.clear
        tempValue.borderStyle = .none
        tempValue.textAlignment = .center
        tempValue.font = .systemFont(ofSize: 20)
        
        button22.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button22.layer.borderWidth = 1.0
        button22.layer.borderColor = UIColor.white.cgColor
        button22.layer.cornerRadius = 10
        summImage.image = UIImage(named: "weather-partly-cloudy")
        summValue.text = json["currently"]["summary"].stringValue
        summValue.numberOfLines = Int(summValue.text!.count/10) + 1
        if(json["currently"]["icon"].stringValue == "clear-day"){
            summImage.image = UIImage(named: "weather-sunny")
        }
        else if(json["currently"]["icon"].stringValue == "clear-night"){
            summImage.image = UIImage(named: "weather-night")
        }
        else if(json["currently"]["icon"].stringValue == "rain"){
            summImage.image = UIImage(named: "weather-rainy")
        }
        else if(json["currently"]["icon"].stringValue == "snow"){
            summImage.image = UIImage(named: "weather-snowy")
        }
        else if(json["currently"]["icon"].stringValue == "sleet"){
            summImage.image = UIImage(named: "weather-snowy-rainy")
        }
        else if(json["currently"]["icon"].stringValue == "wind"){
            summImage.image = UIImage(named: "weather-windy-variant")
        }
        else if(json["currently"]["icon"].stringValue == "fog"){
            summImage.image = UIImage(named: "weather-fog")
        }
        else if(json["currently"]["icon"].stringValue == "cloudy"){
            summImage.image = UIImage(named: "weather-cloudy")
        }
        else if(json["currently"]["icon"].stringValue == "partly-cloudy-night"){
            summImage.image = UIImage(named: "weather-night-partly-cloudy")
        }
        else if(json["currently"]["icon"].stringValue == "partly-cloudy-day"){
            summImage.image = UIImage(named: "weather-partly-cloudy")
        }
        else{
            summImage.image = UIImage(named: "weather-sunny")
        }
        summValue.backgroundColor = UIColor.clear
        summValue.textAlignment = .center
        summValue.font = .systemFont(ofSize: 20)
        
        button23.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button23.layer.borderWidth = 1.0
        button23.layer.borderColor = UIColor.white.cgColor
        button23.layer.cornerRadius = 10
        humidValue.text = String(round(json["currently"]["humidity"].doubleValue*10000)/100) + " %"
        humidValue.backgroundColor = UIColor.clear
        humidValue.borderStyle = .none
        humidValue.textAlignment = .center
        humidValue.font = .systemFont(ofSize: 20)
        
        button33.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button33.layer.borderWidth = 1.0
        button33.layer.borderColor = UIColor.white.cgColor
        button33.layer.cornerRadius = 10
        ozoneValue.text = String(json["currently"]["ozone"].doubleValue)+" DU"
        ozoneValue.backgroundColor = UIColor.clear
        ozoneValue.borderStyle = .none
        ozoneValue.textAlignment = .center
        ozoneValue.font = .systemFont(ofSize: 20)
        
        button32.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button32.layer.borderWidth = 1.0
        button32.layer.borderColor = UIColor.white.cgColor
        button32.layer.cornerRadius = 10
        cloudValue.text = String(json["currently"]["cloudCover"].doubleValue)+" %"
        cloudValue.backgroundColor = UIColor.clear
        cloudValue.borderStyle = .none
        cloudValue.textAlignment = .center
        cloudValue.font = .systemFont(ofSize: 20)
        
        
        button31.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button31.layer.borderWidth = 1.0
        button31.layer.borderColor = UIColor.white.cgColor
        button31.layer.cornerRadius = 10
        visibValue.text = String(round(json["currently"]["visibility"].doubleValue*100)/100) + " miles"
        visibValue.backgroundColor = UIColor.clear
        visibValue.borderStyle = .none
        visibValue.textAlignment = .center
        visibValue.font = .systemFont(ofSize: 20)
    }
}
