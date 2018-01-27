//
//  Analytics.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/22/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import Foundation
import Mixpanel

struct Analytics {
    
    struct Events {
        static let loggedIn = "Logged in Succesful"
        static let loginErrorAlert = "Error Login Alert Shown"
        static let login = "Login Opened"
        static let aboutUs = "About Us Opened"
        static let faq = "FAQ Opened"
        static let chapters = "Chapters View Opened"
        static let chapterSelected = "Chapter Selected"
        static let nextSwipe = "Next Swipe"
        static let previousSwipe = "Previous Swipe"
        static let answerButtonSelected = "Show Answer Button Selected"
        static let rationaleButtonSelected = "Show Rationale Button Selected"
        static let incorrectAnswer = "Incorrect Answer Selected"
    }
    
    static func track(event: String, properties: Properties? = nil) {
        Mixpanel.mainInstance().track(event: event, properties: properties)
    }
    
    static func initializeTracking() {
        Mixpanel.initialize(token: "a35f0d52ea84fc0181dd0ffcc92ef60a")
    }
}





