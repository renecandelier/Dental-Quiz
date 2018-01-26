//
//  FAQViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/3/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var pdfFile = "FAQs"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        track(event: "FAQ Opened")
        if let pdf = getPDF(pdfFileName: pdfFile)  {
            let req = URLRequest(url: pdf)
            webView.loadRequest(req)
        }
    }


}
