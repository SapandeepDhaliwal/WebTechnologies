//
//  WeatherPage.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/24/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON
import Toast_Swift

class WeatherPage: UIView, UITableViewDataSource {
    
    
    @IBOutlet weak var addFav: UIButton!
    
    @IBOutlet weak var thirdSubView: UITableView!
    @IBOutlet weak var pressureImage: UIImageView!
    @IBOutlet weak var visibilityImage: UIImageView!
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var humidImage: UIImageView!
    @IBOutlet weak var pressureValue: UITextField!
    @IBOutlet weak var visibilityValue: UITextField!
    @IBOutlet weak var windValue: UITextField!
    @IBOutlet weak var humidValue: UITextField!
    @IBOutlet weak var weatherButton: UIButton!
    weak var delegate:FavDelegate?
    
    var globJson:JSON = []
    var city:String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (globJson.isEmpty) {
            return 0
        }
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: thirdSubViewTableViewCell = thirdSubView.dequeueReusableCell(withIdentifier: "newIden", for: indexPath) as! thirdSubViewTableViewCell

        
        let date = Date(timeIntervalSince1970: globJson["daily"]["data"][indexPath[1]]["time"].double!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let sunrise = Date(timeIntervalSince1970: globJson["daily"]["data"][indexPath[1]]["sunriseTime"].double!)
        
        let sunset = Date(timeIntervalSince1970: globJson["daily"]["data"][indexPath[1]]["sunsetTime"].double!)
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = .current
        timeFormatter.dateFormat = "HH:mm"

        
    
        
        cell.date.text = dateFormatter.string(from: date)
        if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "clear-day"){
            cell.icon.image = UIImage(named: "weather-sunny")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "clear-night"){
            cell.icon.image = UIImage(named: "weather-night")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "rain"){
            cell.icon.image = UIImage(named: "weather-rainy")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "snow"){
            cell.icon.image = UIImage(named: "weather-snowy")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "sleet"){
            cell.icon.image = UIImage(named: "weather-snowy-rainy")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "wind"){
            cell.icon.image = UIImage(named: "weather-windy-variant")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "fog"){
            cell.icon.image = UIImage(named: "weather-fog")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "cloudy"){
            cell.icon.image = UIImage(named: "weather-cloudy")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "partly-cloudy-night"){
            cell.icon.image = UIImage(named: "weather-night-partly-cloudy")
        }
        else if(globJson["daily"]["data"][indexPath[1]]["icon"].stringValue == "partly-cloudy-day"){
            cell.icon.image = UIImage(named: "weather-partly-cloudy")
        }
        else{
            cell.icon.image = UIImage(named: "weather-sunny")
        }
        
        cell.sunrisreTime.text = timeFormatter.string(from: sunrise)
        cell.sunriseImage.image = UIImage(named: "weather-sunset-up")
        cell.sunsetTime.text = timeFormatter.string(from: sunset)
        cell.sunsetImage.image = UIImage(named: "weather-sunset-down")
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    
    
   
    func resizeText(string1: String, string2: String,string3: String){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let buttonText = NSMutableAttributedString(string: string1, attributes: [NSAttributedString.Key.font: /*UIFont.systemFont(ofSize: 40),*/ UIFont.boldSystemFont(ofSize: 40), NSAttributedString.Key.paragraphStyle:paragraphStyle])
        
        buttonText.append(NSMutableAttributedString(string: string2, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.paragraphStyle:paragraphStyle]))
        
        buttonText.append(NSMutableAttributedString(string: string3, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25),
            NSAttributedString.Key.paragraphStyle:paragraphStyle]))
        weatherButton.setAttributedTitle(buttonText, for: .normal)
    }
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func setLoadingView(){
        addFav.isHidden = false
        addFav.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        weatherButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.resizeText(string1: "Loading..\n", string2: "Loading..\n", string3: "Loading..")
        self.backgroundColor = UIColor.clear
        weatherButton.layer.borderWidth = 1.0
        weatherButton.layer.borderColor = UIColor.white.cgColor
        weatherButton.layer.cornerRadius = 10

        weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-sunny")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        //second static view
        humidValue.text = ""
        humidValue.backgroundColor = UIColor.clear
        humidValue.borderStyle = .none
        humidValue.textAlignment = .center
        humidValue.font = UIFont(name:"System 14.0", size: 19.0)
        humidImage.image = UIImage(named: "water-percent")
        
        
        windValue.text = ""
        windValue.backgroundColor = UIColor.clear
        windValue.borderStyle = .none
        windValue.textAlignment = .center
        windValue.font = UIFont(name:"System 14.0", size: 19.0)
        windImage.image = UIImage(named: "weather-windy")
        
        visibilityValue.text = ""
        visibilityValue.backgroundColor = UIColor.clear
        visibilityValue.borderStyle = .none
        visibilityValue.textAlignment = .center
        visibilityValue.font = UIFont(name:"System 14.0", size: 19.0)
        visibilityImage.image = UIImage(named: "eye-outline")
        
        pressureValue.text = ""
        pressureValue.backgroundColor = UIColor.clear
        pressureValue.borderStyle = .none
        pressureValue.textAlignment = .center
        pressureValue.font = UIFont(name:"System 14.0", size: 19.0)
        pressureImage.image = UIImage(named: "gauge")
        
        
        //third subview
        thirdSubView.register(UINib(nibName: "thirdSubViewTableViewCell", bundle: nil), forCellReuseIdentifier: "newIden")
        thirdSubView.dataSource = self
        thirdSubView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        thirdSubView.layer.cornerRadius = 10
    }
    
    
    func setfirstSubView(json:JSON , plus:Bool){
        let defaults = UserDefaults.standard
        var cross:Bool = false
        if var locArray = defaults.array(forKey: "favCitiesArray"){
            if(locArray.count > 0){
                for i in 0...locArray.count-1{
                    var addr = locArray[i] as! String
                    
                    if(addr == city){
                        cross = true
                        
                    }
                }
            }
        }
        if(plus == true && cross == true){
            
            addFav.setImage(UIImage(named: "trash-can"), for: .normal)
            addFav.isHidden = false
        }
        else if(plus == true){
            addFav.setImage(UIImage(named: "plus-circle"), for: .normal)
            addFav.isHidden = false
        }
        else{
            addFav.isHidden = true
        }
        
        addFav.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)


        globJson = json

        var temp = json["currently"]["temperature"].intValue
        var summ = json["currently"]["summary"].string ?? ""
        weatherButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.resizeText(string1: String(temp)+"ºF\n", string2: summ+"\n", string3: String(city.split(separator: ",")[0]))
        self.backgroundColor = UIColor.clear
        weatherButton.layer.borderWidth = 1.0
        weatherButton.layer.borderColor = UIColor.white.cgColor
        weatherButton.layer.cornerRadius = 10

        
        if(json["currently"]["icon"].stringValue == "clear-day"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-sunny")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "clear-night"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-night")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
            
        }
        else if(json["currently"]["icon"].stringValue == "rain"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-rainy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "snow"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-snowy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "sleet"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-snowy-rainy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "wind"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-windy-variant")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "fog"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-fog")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "cloudy"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-cloudy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "partly-cloudy-night"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-night-partly-cloudy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else if(json["currently"]["icon"].stringValue == "partly-cloudy-day"){
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-partly-cloudy")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        else{
            weatherButton.setImage(self.ResizeImage(image: UIImage(named: "weather-sunny")!, targetSize: CGSize(width: 140.0, height: 140.0)), for: .normal)
        }
        
        
        //second static view
        humidValue.text = String(round(json["currently"]["humidity"].doubleValue*10000)/100) + " %"
        humidValue.backgroundColor = UIColor.clear
        humidValue.borderStyle = .none
        humidValue.textAlignment = .center
        humidValue.font = UIFont(name:"System 14.0", size: 19.0)
        humidImage.image = UIImage(named: "water-percent")
        
        
        windValue.text = String(round(json["currently"]["windSpeed"].doubleValue * 100)/100) + " mph"
        windValue.backgroundColor = UIColor.clear
        windValue.borderStyle = .none
        windValue.textAlignment = .center
        windValue.font = UIFont(name:"System 14.0", size: 19.0)
        windImage.image = UIImage(named: "weather-windy")
        
        let vis = round(json["currently"]["visibility"].doubleValue * 100)/100
        visibilityValue.text = String(vis) + " miles"
        visibilityValue.backgroundColor = UIColor.clear
        visibilityValue.borderStyle = .none
        visibilityValue.textAlignment = .center
        visibilityValue.font = UIFont(name:"System 14.0", size: 19.0)
        visibilityImage.image = UIImage(named: "eye-outline")
        
        pressureValue.text = String(json["currently"]["pressure"].doubleValue)+" mb"
        pressureValue.backgroundColor = UIColor.clear
        pressureValue.borderStyle = .none
        pressureValue.textAlignment = .center
        pressureValue.font = UIFont(name:"System 14.0", size: 19.0)
        pressureImage.image = UIImage(named: "gauge")
        
        
        //third subview
        thirdSubView.register(UINib(nibName: "thirdSubViewTableViewCell", bundle: nil), forCellReuseIdentifier: "newIden")
        thirdSubView.dataSource = self
        thirdSubView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        thirdSubView.layer.cornerRadius = 10
        
    }
    
    


    @objc func buttonAction(){

        let defaults = UserDefaults.standard
        if var locArray = defaults.array(forKey: "favCitiesArray"){
            var cross:Bool = false
            var idx:Int = 0
            if(locArray.count > 0){
                for i in 0...locArray.count-1{
                    var addr = locArray[i] as! String
                   
                    if(addr == city){
                        cross = true
                        idx = i
                        
                    }
                }
            }
            if(cross == false){
                locArray.append(city)
                defaults.set(locArray, forKey: "favCitiesArray")
                addFav.setImage(UIImage(named: "trash-can"), for: .normal)
                self.hideAllToasts()
                self.makeToast("\(String(city.split(separator: ",")[0])) was added to the Favorite List")
                self.delegate?.updateFavorite(city: city, del: false)
            }
            else{
                locArray.remove(at: idx)
                defaults.set(locArray, forKey: "favCitiesArray")
                addFav.setImage(UIImage(named: "plus-circle"), for: .normal)
                
                self.delegate?.updateFavorite(city: city, del: true)
                self.hideAllToasts()
                self.makeToast("\(String(city.split(separator: ",")[0])) was removed from the Favorite List")
            }
        }
        else{
            var arr = [String]()
            arr.append(city)
            defaults.set(arr, forKey: "favCitiesArray")
            self.delegate?.updateFavorite(city: city, del: false)
        }
        
        
    }
    

}


protocol FavDelegate:class {
    func updateFavorite(city:String, del:Bool)
}
