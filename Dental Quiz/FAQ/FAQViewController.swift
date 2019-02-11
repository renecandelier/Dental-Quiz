//
//  FAQViewController.swift
//  Dental Quiz
//

import UIKit

class FAQViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var pdfFile = "FAQs"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Utils.getPDF(pdfFileName: pdfFile)  {
            let req = URLRequest(url: pdf)
            webView.loadRequest(req)
        }
    }


}
