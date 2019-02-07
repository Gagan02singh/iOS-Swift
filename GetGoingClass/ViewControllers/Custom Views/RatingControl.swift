//
//  RatingControl.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/28/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    //Mark: - Properties
    var stars = [UIButton]()
    var rating : Int = 0{
        didSet {
            updateRating()
        }
    }
 /*   override init(frame: CGRect){
        super.init(frame: frame)
        setupButtons()
    }
*/
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    func updateRating() {
        for (index, star) in stars.enumerated(){
            star.isSelected = index < rating
        }
    }
    
    func setupButtons() {
        //for _ in stars{
            
            let filledStar = UIImage(named : "StarFull")
            let emptyStar = UIImage(named: "StarEmpty")
            
            for _ in 0..<5{
                let button = UIButton()
                button.setImage(emptyStar, for: .normal)
                button.setImage(filledStar, for: .selected)
                
                button.translatesAutoresizingMaskIntoConstraints=false
                let buttonSize : CGFloat = 22.0
                button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
                button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
                addArrangedSubview(button)
                stars.append(button)
            }
        }
    }
//}
