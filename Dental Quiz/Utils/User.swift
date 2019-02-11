//
//  User.swift
//  Dental Quiz
//

import Foundation

struct User {
    var pin = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    var seminar = ""
    static let userLoggedIn = "UserLoggedIn"
    
    var dictionary: [String: String] {
        return [Constants.pin: pin,
                Constants.first: firstName,
                Constants.last: lastName,
                Constants.email: email,
                Constants.seminar: seminar]
    }
    
    struct Constants {
        static let pin = "pin"
        static let first = "first"
        static let last = "last"
        static let email = "email"
        static let seminar = "seminar"
    }
    
}

func parseUserFromPList(plistName: String) -> [User]? {
    guard let usersArray = Utils.getDictionaryFromPlist(plistName: plistName) else { return nil }
    var users = [User]()
    usersArray.forEach { (userDictionary) in
        var user1 = User()
        guard let pin = userDictionary[User.Constants.pin] as? String,
        let firstName = userDictionary[User.Constants.first] as? String,
        let lastName = userDictionary[User.Constants.last] as? String,
        let email = userDictionary[User.Constants.email] as? String,
        let seminar = userDictionary[User.Constants.seminar] as? String else { return }
            user1.pin = pin.trimmingCharacters(in: .whitespaces)
            user1.lastName = lastName
            user1.firstName = firstName
            user1.seminar = seminar
            user1.email = email
            users.append(user1)
    }
    return users.isEmpty ? nil : users
}
