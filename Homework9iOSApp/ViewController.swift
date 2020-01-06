//
//  ViewController.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/23/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import Toast_Swift
import SwiftSpinner

class ViewController: UIViewController,UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate, UIScrollViewDelegate, UITableViewDelegate {
    
 
    var manager: CLLocationManager = CLLocationManager()
    var filteredData: [String]!
    var pages:[WeatherPage] = [];
    var nextPageJson:JSON = []
    var thisPageJson:JSON = []
    var currentCity:String = ""
    var targetCity:String = ""
    var currentAddress:String = ""
    var allPagesLoaded:Bool = false
    var updateView:Bool = true
    var previousFav = [String]()
    var skipDefaultLoad:Bool = false
    // MARK: Properties
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var citySearchBar: UISearchBar!
    

    @IBOutlet weak var cityTableView: UITableView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    func tableView(_ cityTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = filteredData{
            return count.count
        }
        else{
             return 0
        }
    }
    
    func tableView(_ cityTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var addr = filteredData[indexPath[1]]
        SwiftSpinner.show(delay: 0, title: "Fetching Weather Details for \(String(addr.split(separator: ",")[0]))...", animated: true)
        var addrArray = addr.split(separator: ",")
        var city = addrArray[0]
        targetCity = String(addr)
        var state = " "
        if(addrArray.count == 3){
            state = String(addrArray[1])
        }
        
        if let urltext = "http://hw8submission.appspot.com/street/ &city/\(city)&state/\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            Alamofire.request(urltext).responseJSON { response in
                if let json = response.result.value {
                    self.nextPageJson = JSON(json)
                    self.performSegue(withIdentifier: "newCitySearchSegue", sender: self)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show(delay: 0, title: "Loading...", animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(self.updateView ||
            !self.isSameFav(previousFav: self.previousFav)){
            self.cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
            
            cityTableView.tableFooterView = UIView(frame: .zero)
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "background")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            navBar.titleView = citySearchBar
            navBar.rightBarButtonItem = nil
            citySearchBar.delegate = self
            cityTableView.dataSource = self
            cityTableView.delegate = self
            scrollView.delegate = self
            cityTableView.layer.cornerRadius = 10
            self.view.addSubview(scrollView)
            self.view.addSubview(cityTableView)
            manager.delegate = self
            manager.requestLocation()
            if(!self.skipDefaultLoad){
                self.loadDefaultPage()
            }
            else{
                self.skipDefaultLoad = false
            }

            pageControl.numberOfPages = pages.count
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            pageControl.updateCurrentPageDisplay()
            view.bringSubviewToFront(pageControl)
            self.updateView = false
            let defaults = UserDefaults.standard
            self.previousFav = defaults.array(forKey: "favCitiesArray") as! [String]
        }
        self.cityTableView.isHidden = true
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 20)], for: .normal)
    }
    
    func isSameFav(previousFav:[String])->Bool{
        
         let defaults = UserDefaults.standard
        if let favCityList = defaults.array(forKey: "favCitiesArray"){
            if(previousFav.count != favCityList.count){
                return false
            }
            else{
                var same = true
                if(favCityList.count>0){
                    for i in 0...favCityList.count-1{
                        if(favCityList[i] as! String != previousFav[i]){
                            same = false
                        }
                        
                    }
                }
                return same
            }
        }
        else{
            if(previousFav.count == 0){
                return true
            }
            else{
                return false
            }
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted,.denied,.notDetermined:
            print("error")
        default:
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locationObj = locations.last {
                manager.stopUpdatingLocation()
                manager.delegate = nil

                getWeatherLatLong(lat: locationObj.coordinate.latitude, long: locationObj.coordinate.longitude)
        }
    }
    
    
    //Send Request to Server with lat long
    func getWeatherLatLong(lat:Double, long:Double){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                
                // city name
                if let city = placeMark.subAdministrativeArea {
                    self.currentCity = city
                    self.currentAddress = city+", "
                }
                if let state = placeMark.administrativeArea {
                    self.currentAddress+=state+", "
                }
                if let country = placeMark.country {
                    self.currentAddress+=country
                }
                
                
        })
        if let urltext = "http://hw8submission.appspot.com/lat/\(lat)&long/\(long)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            Alamofire.request(urltext).responseJSON { response in
                if let json = response.result.value {
                    let addr = JSON(json)
                    self.thisPageJson = addr
                    self.singleWeatherPage(json: addr)
                }
            }
        }

    }
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if !searchText.isEmpty{
            if let urltext = "http://hw8submission.appspot.com/city/\(searchText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                Alamofire.request(urltext).responseJSON { response in
                    if let json = response.result.value {
                        let addr = JSON(json)
                        self.filteredData = addr["predictions"].arrayValue.map{$0["structured_formatting"]["main_text"].stringValue + ", " + $0["structured_formatting"]["secondary_text"].stringValue}
                          if self.filteredData.count == 0{
                            self.cityTableView.isHidden = true
                        }
                        else{
                            self.cityTableView.isHidden = false
                        }
                        self.cityTableView.reloadData()
                    }
                }
            }
        }
        else{
            self.cityTableView.isHidden = true
            self.filteredData.removeAll()
            self.cityTableView.reloadData()
        }
    }
    
    func loadDefaultPage(){
        let page1:WeatherPage = Bundle.main.loadNibNamed("WeatherPage", owner: self, options: nil)?.first as! WeatherPage
        page1.city = self.currentAddress
        page1.setLoadingView()
        page1.weatherButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if (pages.count > 0){
            pages[0] = page1
        }
        else{
            pages.append(page1)
        }
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        self.scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
        self.setupPageScrollView(pages: pages)
        self.allPagesLoaded = true
    }
    
    func getDefaultPage()->WeatherPage{
        let page1:WeatherPage = Bundle.main.loadNibNamed("WeatherPage", owner: self, options: nil)?.first as! WeatherPage
        page1.city = self.currentAddress
        page1.setLoadingView()
        page1.weatherButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return page1
    }
    
    func singleWeatherPage(json:JSON){
        pages = []
        let page1:WeatherPage = Bundle.main.loadNibNamed("WeatherPage", owner: self, options: nil)?.first as! WeatherPage
        page1.city = self.currentAddress
        page1.setfirstSubView(json:json, plus:false)
        page1.weatherButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        pages.append(page1)
        let defaults = UserDefaults.standard
        if let favCityList = defaults.array(forKey: "favCitiesArray"){
            if favCityList.count == 0{
                pageControl.numberOfPages = pages.count
                pageControl.currentPage = 0
                self.setupPageScrollView(pages: pages)
                self.allPagesLoaded = true
                SwiftSpinner.hide()
            }
            else{
                for i in 0...favCityList.count-1{
                    createWeatherPages(addr:favCityList[i] as! String,
                                       listCount: favCityList.count)
                }
            }
        }
        else{
            pageControl.numberOfPages = pages.count
            pageControl.currentPage = 0
            self.setupPageScrollView(pages: pages)
            self.allPagesLoaded = true
            SwiftSpinner.hide()
        }
    }
    
    @objc func buttonAction(){
        self.performSegue(withIdentifier: "tabViewSegue", sender: self)
    }

    
    func createWeatherPages(addr:String, listCount:Int) {
        
        
        var addrArray = addr.split(separator: ",")
        var city = addrArray[0]
        targetCity = String(addr)
        var state = " "
        if(addrArray.count == 3){
            state = String(addrArray[1])
        }
        
        if let urltext = "http://hw8submission.appspot.com/street/ &city/\(city)&state/\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            Alamofire.request(urltext).responseJSON { response in
                if let json = response.result.value {
                   var json = JSON(json)
                    let page1:WeatherPage = Bundle.main.loadNibNamed("WeatherPage", owner: self, options: nil)?.first as! WeatherPage
                    page1.city = addr
                    page1.setfirstSubView(json:json, plus:true)
                    page1.delegate = self
                    page1.weatherButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                    self.pages.append(page1)
                    if(self.pages.count == listCount+1){
                        self.allPagesLoaded = true
                        self.setupPageScrollView(pages: self.pages)
                        self.pageControl.numberOfPages = self.pages.count
                        SwiftSpinner.hide()
                    }
                }
            }
        }
        
    }
    
    func setupPageScrollView(pages : [WeatherPage]) {
        
        let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< pages.count {
            pages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(pages[i])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if(segue.identifier == "newCitySearchSegue"){
            let secondViewController = segue.destination as! weatherViewController

            secondViewController.json = nextPageJson
            secondViewController.addPlus = true
            self.navBar.title = "Weather"
            secondViewController.city = self.targetCity
            secondViewController.Spindelegate = self

        }
        else if(segue.identifier == "tabViewSegue"){
            let firstTabViewController = segue.destination as! UITabBarController

            let pageidx = pageControl.currentPage

            let firstTab = firstTabViewController.viewControllers![0] as! FirstTabViewController
            firstTab.json = pages[pageidx].globJson
            firstTab.city = pages[pageidx].city
            let secondTab = firstTabViewController.viewControllers![1] as! SecondTabViewController
            secondTab.json = pages[pageidx].globJson
            let thirdTab = firstTabViewController.viewControllers![2] as! ThirdTabViewController
            thirdTab.json = pages[pageidx].globJson
            thirdTab.city = pages[pageidx].city
            self.navBar.title = "Weather"
        }
    }
}

extension ViewController:FavDelegate{
    func updateFavorite(city:String, del:Bool){
        
        if (del){
            if(pages.count > 0){
                for i in 1...pages.count-1{
                    if(pages[i].city == city){

                        let subViews = self.scrollView.subviews
                        for subview in subViews{

                            if let thisview = subview as? WeatherPage{
                                if (thisview.city == city){

 
                                    let newpage = self.getDefaultPage()
                                    pages.remove(at: i)
                                    pages.insert(newpage, at: i)
                                    pageControl.numberOfPages = pages.count - 1

                                    setupPageScrollView(pages: pages)

                                    self.view.hideAllToasts()
                                    self.view.makeToast("\(String(city.split(separator: ",")[0])) was removed from the Favorite List")
                                    self.updateView = true
                                    self.skipDefaultLoad = true
                                    self.viewWillAppear(false)
                                    
                                    if(i == pages.count - 1){
                                        pageControl.currentPage = i-1
                                    }
                                    else{
                                        pageControl.currentPage = i
                                    }
                                self.scrollView.setContentOffset(CGPoint(x:newpage.frame.width*CGFloat(pageControl.currentPage), y:0), animated: false)
                                    break
                                }

                            }
                        }
                        break
                        
                    }
                }
            }
        }
        else{
            self.updateView = true
        }
    }
}

extension ViewController:SpinnerDelegate{
    func StopSpinner(){
        SwiftSpinner.hide()
    }
}
