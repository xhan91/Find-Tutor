//
//  SearchViewController.swift
//  Find Tutor
//
//  Created by han xu on 2016-04-13.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var speciltiesTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    var searchCriteria = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        
        
        performSegueWithIdentifier("fromSearchToResult", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let searchString = speciltiesTextField.text!
        searchCriteria = searchString.characters.split(" ").map(String.init)
        if let destination = segue.destinationViewController as? SearchTableViewController {
            destination.searchCriteria = self.searchCriteria
        }
    }
}
