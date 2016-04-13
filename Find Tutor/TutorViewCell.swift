//
//  TutorViewCell.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class TutorViewCell: UITableViewCell {

    var tutor: Tutor? {
        didSet{
            tutorNameLabel.text = (tutor?.firstName)! + " " + (tutor?.lastName)!
            let specialString = tutor?.specialties.joinWithSeparator(", ")
            tutorSpecialtiesLabel.text = "Tutor Specialties: " + specialString!
            if let location = tutor?.location {
                distanceLabel.text = "Distance to you: \(location)"
            } else {
                distanceLabel.text = "Distance to you: N/A"
            }
        }
    }
    
    @IBOutlet weak var tutorNameLabel: UILabel!
    @IBOutlet weak var tutorSpecialtiesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
}
