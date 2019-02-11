//
//  PDFViewController.swift
//  Dental Quiz
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var pdfFile = "About Us"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Utils.getPDF(pdfFileName: pdfFile)  {
            let req = URLRequest(url: pdf)
            webView.loadRequest(req)
        }
    }
    
}
