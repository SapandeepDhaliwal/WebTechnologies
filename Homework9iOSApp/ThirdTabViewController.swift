//
//  ThirdTabViewController.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/27/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class ThirdTabViewController: UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var imageScroll: UIScrollView!
    var json:JSON = []
    var city:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let page1:thirdTabView = Bundle.main.loadNibNamed("ThirdTabViewController", owner: self, options: nil)?.first as! thirdTabView
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        imageScroll.delegate = self
        imageScroll.isPagingEnabled = false
        self.view.addSubview(imageScroll)
        page1.setThirdTabView(json: json, city: city, scrollView: imageScroll)
        SwiftSpinner.show(delay: 0, title: "Fetching Google Images...", animated: true)
    }
}
