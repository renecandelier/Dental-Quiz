//
//  WelcomeViewController.swift
//  Dental Quiz
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
    }
}
