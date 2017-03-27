//
//  HostGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class HostGoalsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func eventDetailsPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }
}
