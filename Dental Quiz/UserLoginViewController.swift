//
//  UserLoginViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/17/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit
import Mixpanel

class UserLoginViewController: UIViewController {

    @IBOutlet weak var userPinTextField: UITextField!
    var users = [User]()
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        track(event: "Login Opened")
        guard let usersPlist = parseUserFromPList(plistName: "Users") else { return }
        users = usersPlist
    }
    
    @IBAction func signInButtonSelected(_ sender: UIButton) {
        users.forEach { (user) in
            if userPinTextField.text == user.pin {
                track(event: "Logged in Succesful", properties: user.dictionary)
                userName = "\(user.firstName)\(user.lastName)"
                UserDefaults.standard.set(true, forKey: User.userLoggedIn)
                performSegue(withIdentifier: WelcomeViewController.className, sender: self)
                return
            }
        }
        showAlert(title: "Error", message: "The pin entered is incorrect. Please try again.")
    }
    
    func showAlert(title: String, message: String) {
        track(event: "Error Login Alert Shown")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WelcomeViewController.className {
            let welcomeVC = segue.destination as! WelcomeViewController
            welcomeVC.userName = userName
        }
    }
}
