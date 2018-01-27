//
//  PDFViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/2/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var pdfFile = "About Us"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.track(event: Analytics.Events.aboutUs)
        if let pdf = Utils.getPDF(pdfFileName: pdfFile)  {
            let req = URLRequest(url: pdf)
            webView.loadRequest(req)
        }
    }
    
}
