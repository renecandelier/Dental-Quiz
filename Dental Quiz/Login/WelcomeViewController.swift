//
//  WelcomeViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/18/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.track(event: "Welcome Screen Opened")
        userNameLabel.text = userName
    }
}
