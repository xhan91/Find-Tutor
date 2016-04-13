//
//  File.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation

class Tutor {
    
    let id: String
    let firstName: String
    let lastName: String
    let specialties: [String]
    
    var location: [Float]?
    
    init(id: String, firstName: String, lastName: String, specialties: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.specialties = specialties
    }
    
}