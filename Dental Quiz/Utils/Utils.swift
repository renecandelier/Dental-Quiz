//
//  Utils.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/27/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    
    static func boldText(from string: String, boldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attributes = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)]
        let nonBoldAttribute = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attributes)
        if let range = boldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    
    static func getPDF(pdfFileName: String) -> URL? {
        guard let pdfURL = Bundle.main.url(forResource: pdfFileName, withExtension: "pdf") else { return .none }
        return pdfURL
    }
    
    static func getDictionaryFromPlist(plistName: String) -> [[String: Any]]? {
        guard let fileUrl = Bundle.main.url(forResource: plistName, withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) else { return nil }
        if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] {
            guard let result = result else { return nil }
            return result
        }
        return nil
    }
    
    static func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "UserLoggedIn")
    }
}

struct Colors {
    static let lightBlue = UIColor(red:0.14, green:0.80, blue:0.93, alpha:0.3)
    static let red = UIColor(red:1, green:28/255, blue:0, alpha:0.1)
}
