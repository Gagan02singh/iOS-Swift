//
//  Details.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 2/6/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation


class Details{
    
      let phoneNo: String?
      let website: String?
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String else {return nil}
        
        self.phoneNo = json["formatted_phone_number"] as? String
        self.website = json["website"] as? String
    }
    
}
