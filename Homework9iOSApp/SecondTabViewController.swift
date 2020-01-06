//
//  SecondTabViewController.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/27/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondTabViewController: UIViewController {
    var json:JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let page1:secondTabView = Bundle.main.loadNibNamed("SecondTabViewController", owner: self, options: nil)?.first as! secondTabView
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        page1.setSecondTabView(json: json)
        
    }

}
