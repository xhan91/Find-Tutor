//
//  TutorDetails.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import Foundation

class TutorDetails: Tutor {
    
//    let id: String
//    let firstName: String
//    let lastName: String
//    let specialties: [String]
//    
//    var location: [String]?
    
    let email: String
    let phoneNumber: String
    let githubUsername: String
    let avatarURL: String

    let admin: Bool
    let onDuty: Bool
    
    // May be empty

    var twitter: String?
    var skype: String?
    var slack: String?
    var customAvatarURL: String?
    var customAvatarThumbURL: String?
    var companyName: String?
    var companyURL: String?
    var bio: String?
    var quirkyFact: String?
    var createdAt: String?
    var updatedAt: String?
    
    init(id: String, firstName: String, lastName: String, specialties: [String], email: String, phoneNumber: String, githubUsername: String, avatarURL: String, admin: Bool, onDuty: Bool) {
        self.email = email
        self.phoneNumber = phoneNumber
        self.githubUsername = githubUsername
        self.avatarURL = avatarURL
        self.admin = admin
        self.onDuty = onDuty
        super.init(id: id, firstName: firstName, lastName: lastName, specialties: specialties)
    }
    
}