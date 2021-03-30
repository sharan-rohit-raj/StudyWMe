//
//  LoginModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-25.
//

import Foundation
class LoginModel: ObservableObject{
    //Data for Login View
    @Published var emailLogin = ""
    @Published var passwordLogin = ""
}
