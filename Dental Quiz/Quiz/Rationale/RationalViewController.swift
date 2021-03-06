//
//  RationalViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/7/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class RationalViewController: UIViewController {

    var rationalTapHandler: (() -> Void)?
    var rationalText: String? {
        didSet {
            rationalTextView.text = rationalText ?? ""
        }
    }
    
    @IBOutlet weak var rationalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func swipeDownRationalView(_ sender: UISwipeGestureRecognizer) {
        rationalTapHandler?()
    }
    
    fileprivate func addShadowToView() {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1, height: 1.1)
        view.layer.shadowRadius = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addShadowToView()
        rationalTextView.text = rationalText
    }
    
    @IBAction func rationalButtonSelected(_ sender: UIButton) {
        rationalTapHandler?()
    }

}
