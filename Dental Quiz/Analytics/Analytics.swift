//
//  Analytics.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/22/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import Foundation
import Mixpanel

func track(event: String, properties: Properties? = nil) {
    Mixpanel.mainInstance().track(event: event, properties: properties)
}

