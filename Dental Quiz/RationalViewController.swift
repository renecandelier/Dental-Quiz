//
//  RationalViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/7/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class RationalViewController: UIViewController {

    var tapHandler: (() -> Void)?
    var rationalText: String? {
        didSet(newValue) {
            rationalTextView.text = newValue ?? ""
        }
    }
    
    @IBOutlet weak var rationalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rationalTextView.text = rationalText
    }
    
    @IBAction func rationalButtonSelected(_ sender: UIButton) {
        tapHandler?()
    }

}
