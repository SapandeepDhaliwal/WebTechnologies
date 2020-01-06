//
//  thirdSubViewTableViewCell.swift
//  CSCIFall19HW9
//
//  Created by Sapandeep Dhaliwal on 11/25/19.
//  Copyright © 2019 Sapandeep. All rights reserved.
//

import UIKit

class thirdSubViewTableViewCell: UITableViewCell {

    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var sunriseImage: UIImageView!
    @IBOutlet weak var sunrisreTime: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
