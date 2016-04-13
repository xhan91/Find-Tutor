//
//  SearchTableViewController.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var searchCriteria = [String]()
    var result = [Tutor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search Result"
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
        searchTutor()
    }

    func searchTutor() {
        let url = NSURL(string: "http://skillsbc.vansortium.com/mentors")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let jsonUnformatted = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) {
                let json = jsonUnformatted as! [[String: AnyObject]]
                for tutorJson in json {
                    if self.searchCriteria.isEmpty {
                        if let id = tutorJson["_id"] as? String,
                            let firstName = tutorJson["first_name"] as? String,
                            let lastName = tutorJson["last_name"] as? String,
                            let tutorSpecialties = tutorJson["specialties"] as? [String] {
                            let tutor = Tutor(id: id, firstName: firstName, lastName: lastName, specialties: tutorSpecialties)
                            if let location = tutorJson["location"] as? [Float] where !(location.contains(0)){
                                tutor.location = location
                            }
                            self.result.append(tutor)
                        }
                    } else {
                        for specialty in self.searchCriteria {
                            let tutorSpecialties = tutorJson["specialties"] as! [String]
                            if tutorSpecialties.contains(specialty) {
                                if let id = tutorJson["_id"] as? String,
                                    let firstName = tutorJson["first_name"] as? String,
                                    let lastName = tutorJson["last_name"] as? String {
                                    let tutor = Tutor(id: id, firstName: firstName, lastName: lastName, specialties: tutorSpecialties)
                                    if let location = tutorJson["location"] as? [Float] where !(location.contains(0)){
                                        tutor.location = location
                                    }
                                    self.result.append(tutor)
                                }
                            }
                        }
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        task.resume()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! TutorViewCell
        cell.tutor = result[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "fromSearchTableToDetail":
                if let cell = sender as? TutorViewCell,
                let destination = segue.destinationViewController as? DetailViewController {
                    destination.tutorID = (cell.tutor?.id)!
                }
            default: break
            }
        }
    }
}
