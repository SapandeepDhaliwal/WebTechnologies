//
//  thirdTabView.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/27/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner

class thirdTabView: UIView {

    var arrayOfImage = [String]()
    var images = [UIImageView]()

    func setThirdTabView(json:JSON, city:String , scrollView: UIScrollView){
        if let urltext = "http://hw8submission.appspot.com/state/\(city)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            Alamofire.request(urltext).responseJSON { response in
                if let json = response.result.value {
                    var locJson = JSON(json)
                    for i in 0...7{
                        self.arrayOfImage.append(locJson["items"][i]["link"].string!)
                    }
                    var newY:CGFloat = 0
                    for i in 0...self.arrayOfImage.count-1{
                        let url = URL(string: self.arrayOfImage[i])
                        do{
                            let data = try Data(contentsOf: url!)
                            let image = UIImage(data: data)
                            let imageView = UIImageView(image: image)
                            if let imageViewHeight = imageView.image?.size.height,
                                let imageViewWidth = imageView.image?.size.width {
                                self.images.append(imageView)
                                
                                let ratio = (imageView.image?.size.width)!/CGFloat(self.frame.size.width)
                                imageView.frame = CGRect(x: CGFloat(0), y: CGFloat(newY), width: CGFloat(self.frame.size.width), height: imageViewHeight/ratio)
                                
                                newY = newY + imageViewHeight/ratio
                                scrollView.contentSize.height = newY
                                scrollView.addSubview(imageView)
                            }
                        }catch let err {
                            print("Error : \(err.localizedDescription)")
                        }
                    }
                    SwiftSpinner.hide()
                }
            }
        }
        
        
       
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 
    }
}
