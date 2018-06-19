//
//  WelcomeViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/18/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var userName = ""
    
    @IBOutlet weak var beginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.layer.borderColor = Colors.mustard.cgColor
        beginButton.layer.borderWidth = 1
        beginButton.layer.cornerRadius = 15
        beginButton.clipsToBounds = true
        Analytics.track(event: "Welcome Screen Opened")
    }
}
