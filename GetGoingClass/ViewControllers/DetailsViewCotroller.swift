//
//  DetailsViewCotroller.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 2/6/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class DetailsViewCotroller: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phone_number: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        websiteLabel.text = detailInfo?.website 
        phone_number.text = detailInfo?.phoneNo
        activity.stopAnimating()
        activity.isHidden = true
        // Do any additional setup after loading the view.
    }
    var detailInfo : Details?
    
}
