//
//  Named.swift
//

import Foundation
import UIKit

protocol Named {
    var className: String {get}
    static var className: String {get}
}

extension NSObject: Named {
    ///returns the class name
    var className: String {
        return type(of: self).className
    }
    ///returns the class name
    @nonobjc static var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
