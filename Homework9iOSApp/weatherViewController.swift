//
//  weatherViewController.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/26/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class weatherViewController: UIViewController {
    
    weak var Spindelegate:SpinnerDelegate?
    var json:JSON = []
    var city:String = ""
    var addPlus:Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let page1:WeatherPage = Bundle.main.loadNibNamed("WeatherPage", owner: self, options: nil)?.first as! WeatherPage
        page1.city = city
        page1.setfirstSubView(json:json , plus:true)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        self.view.addSubview(page1)

        page1.weatherButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = String(self.city.split(separator: ",")[0])
        let twitterButtonItem = UIBarButtonItem(image:UIImage(named: "twitter"), style: UIBarButtonItem.Style.done, target: self, action:#selector(twitterButtonAction))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = twitterButtonItem
        self.Spindelegate?.StopSpinner()
    }
    
    @objc func twitterButtonAction(){
        let justCity = String(self.city.split(separator: ",")[0])
        let tweetText = "The current temperature at \(justCity) is \( json["currently"]["temperature"].intValue)ºF. The weather conditions are \(json["currently"]["summary"].string!.lowercased()) #CSCI571WeatherSearch"

        let tweetString = "https://twitter.com/intent/tweet?text=\(tweetText)"
        let escapedTweetString = tweetString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: escapedTweetString)
        UIApplication.shared.open(url!)
    }
    
    @objc func buttonAction(){
        self.performSegue(withIdentifier: "tabViewSegue2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        self.tabBarController?.title = "City"
        let firstTabViewController = segue.destination as! UITabBarController
        let firstTab = firstTabViewController.viewControllers![0] as! FirstTabViewController
        firstTab.json = json
        firstTab.city = city
        let secondTab = firstTabViewController.viewControllers![1] as! SecondTabViewController
        secondTab.json = json
        let thirdTab = firstTabViewController.viewControllers![2] as! ThirdTabViewController
        thirdTab.json = json
        thirdTab.city = city
    }
}

protocol SpinnerDelegate:class {
    func StopSpinner()
}
