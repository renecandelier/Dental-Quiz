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
        track(event: "Welcome Screen Opened")
        userNameLabel.text = userName
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
