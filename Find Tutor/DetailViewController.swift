//
//  DetailViewController.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var specialtiesLabel: UITextView!
    @IBOutlet weak var emailLabel: UITextView!
    @IBOutlet weak var phoneLabel: UITextView!
    @IBOutlet weak var githubLabel: UITextView!
    @IBOutlet weak var ondutyLabel: UITextView!
    @IBOutlet weak var twitterLabel: UITextView!
    @IBOutlet weak var skypeLabel: UITextView!
    @IBOutlet weak var slackLabel: UITextView!
    @IBOutlet weak var companyLabel: UITextView!
    @IBOutlet weak var bioLabel: UITextView!
    @IBOutlet weak var quickyFactLabel: UITextView!
    
    
    var tutorID = ""
    var tutorDetails: TutorDetails? {
        didSet {
            nameLabel.text = tutorDetails!.firstName + tutorDetails!.lastName
            let data = NSData(contentsOfURL: NSURL(string: tutorDetails!.avatarURL)!)!
            avatarImageView.image = UIImage(data: data)
            let specialtiesString = tutorDetails?.specialties.joinWithSeparator(", ")
            specialtiesLabel.text = specialtiesString!
            emailLabel.text = tutorDetails?.email
            phoneLabel.text = tutorDetails?.phoneNumber
            githubLabel.text = "https://github.com/" + (tutorDetails?.githubUsername)!
            if tutorDetails!.onDuty {
                ondutyLabel.text = "Yes"
            } else {
                ondutyLabel.text = "No"
            }
            if let twitter = tutorDetails?.twitter {
                twitterLabel.text = twitter
            }
            if let skype = tutorDetails?.skype {
                skypeLabel.text = skype
            }
            if let slack = tutorDetails?.slack {
                slackLabel.text = slack
            }
            if let company = tutorDetails?.companyName {
                companyLabel.text = company
                if let companyURL = tutorDetails?.companyURL {
                    companyLabel.text! += companyURL
                }
            }
            if let bio = tutorDetails?.bio {
                bioLabel.text = bio
            }
            if let quickyFact = tutorDetails?.quirkyFact {
                quickyFactLabel.text = quickyFact
            }
            if let urlString = tutorDetails?.customAvatarURL,
                let url = NSURL(string: urlString),
                let data = NSData(contentsOfURL: url),
                let image = UIImage(data: data) {
                avatarImageView.image = image
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tutor Details"
        searchTutorDetail()
    }

    func searchTutorDetail() {
        let url = NSURL(string: "http://skillsbc.vansortium.com/mentors/\(tutorID)")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let jsonUnformatted = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) {
                let tutorJson = jsonUnformatted as! [String: AnyObject]
                if let id = tutorJson["_id"] as? String,
                let firstName = tutorJson["first_name"] as? String,
                let lastName = tutorJson["last_name"] as? String,
                let specialties = tutorJson["specialties"] as? [String],
                let email = tutorJson["email"] as? String,
                let phoneNumber = tutorJson["phone_number"] as? String,
                let githubUsername = tutorJson["github_username"] as? String,
                let avatarURL = tutorJson["avatar_url"] as? String,
                let admin = tutorJson["admin"] as? Bool,
                    let onDuty = tutorJson["on_duty"] as? Bool {
                    let tutorDetails = TutorDetails(id: id, firstName: firstName, lastName: lastName, specialties: specialties, email: email, phoneNumber: phoneNumber, githubUsername: githubUsername, avatarURL: avatarURL, admin: admin, onDuty: onDuty)
                    if let twitter = tutorJson["twitter"] as? String where twitter != "" {
                        tutorDetails.twitter = twitter
                    }
                    if let skype = tutorJson["skype"] as? String where skype != "" {
                        tutorDetails.skype = skype
                    }
                    if let slack = tutorJson["slack"] as? String where slack != "" {
                        tutorDetails.slack = slack
                    }
                    if let customAvatarURL = tutorJson["custom_avatar"]!["url"] as? String where customAvatarURL != "" {
                        tutorDetails.customAvatarURL = customAvatarURL
                    }
                    if let customAvatarThumbURL = tutorJson["custom_avatar"]!["thumb"]!!["url"] as? String where customAvatarThumbURL != "" {
                        tutorDetails.customAvatarThumbURL = customAvatarThumbURL
                    }
                    if let companyName = tutorJson["company_name"] as? String where companyName != "" {
                        tutorDetails.companyName = companyName
                    }
                    if let companyURL = tutorJson["company_url"] as? String where companyURL != "" {
                        tutorDetails.companyURL = companyURL
                    }
                    if let bio = tutorJson["bio"] as? String where bio != "" {
                        tutorDetails.bio = bio
                    }
                    if let quirkyFact = tutorJson["quirky_fact"] as? String where quirkyFact != "" {
                        tutorDetails.quirkyFact = quirkyFact
                    }
                    if let createdAt = tutorJson["created_at"] as? String where createdAt != "" {
                        tutorDetails.createdAt = createdAt
                    }
                    if let updatedAt = tutorJson["updated_at"] as? String where updatedAt != "" {
                        tutorDetails.updatedAt = updatedAt
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        print(tutorJson)
                        self.tutorDetails = tutorDetails
                    })
                }
            }
        }
        task.resume()
    }
    
}
