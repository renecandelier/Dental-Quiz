//
//  User.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 1/17/18.
//  Copyright © 2018 Novus Mobile. All rights reserved.
//

import Foundation

struct User {
    var pin = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    var seminar = ""
    static let userLoggedIn = "UserLoggedIn"
}

func parseUserFromPList(plistName: String) -> [User]? {
    guard let usersArray = getDictionaryFromPlist(plistName: plistName) else { return nil }
    var users = [User]()
    usersArray.forEach { (userDictionary) in
        var user1 = User()
        guard let pin = userDictionary["pin"] as? String,
        let firstName = userDictionary["first"] as? String,
        let lastName = userDictionary["last"] as? String,
        let email = userDictionary["email"] as? String,
        let seminar = userDictionary["seminar"] as? String else { return }
            user1.pin = pin.trimmingCharacters(in: .whitespaces)
            user1.lastName = lastName
            user1.firstName = firstName
            user1.seminar = seminar
            user1.email = email
            users.append(user1)
    }
    return users.isEmpty ? nil : users
}

func isUserLoggedIn() -> Bool {
    return UserDefaults.standard.bool(forKey: "UserLoggedIn")
}
