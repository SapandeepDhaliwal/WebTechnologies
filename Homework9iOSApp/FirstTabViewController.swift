//
//  FirstTabViewController.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/26/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON

class FirstTabViewController: UIViewController {
    var json:JSON = []
    var city:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let page1:firstTabView = Bundle.main.loadNibNamed("FirstTabViewController", owner: self, options: nil)?.first as! firstTabView
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        page1.setFirstTabView(json: json)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = String(self.city.split(separator: ",")[0])
        let twitterButtonItem = UIBarButtonItem(image:UIImage(named: "twitter"), style: UIBarButtonItem.Style.done, target: self, action:#selector(twitterButtonAction))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = twitterButtonItem
    }

    @objc func twitterButtonAction(){
        let justCity = String(self.city.split(separator: ",")[0])
        let tweetText = "The current temperature at \(justCity) is \( json["currently"]["temperature"].intValue)ºF. The weather conditions are \(json["currently"]["summary"].string!.lowercased()) #CSCI571WeatherSearch"
        
        let tweetString = "https://twitter.com/intent/tweet?text=\(tweetText)"
        let escapedTweetString = tweetString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: escapedTweetString)
   
        UIApplication.shared.open(url!)
    }

}
