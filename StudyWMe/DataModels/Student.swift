//
//  User.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import Foundation
class Student {
    var uid: String?
    var email: String?
    var displayName: String?
    var phoneNumber: String?
    var age: String?
    
    init(uid: String, email: String, displayName: String, phoneNumber: String, age: String){
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.phoneNumber = phoneNumber
        self.age = age
    }
}
