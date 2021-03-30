//
//  FieldValidators.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-18.
//

import Foundation
struct FieldValidators{
    
    //MARK:- Sign Up Validation
    func validateSignUp(withEmail email: String, password: String, reEnterPassword: String) -> String{
        var errorMessage = ""
        
        if email == "" || password == "" || reEnterPassword == ""{
            errorMessage = "Cannot leave any field empty"
        }
        else if password != reEnterPassword {
            errorMessage = "Password fields do not match"
        }
        else{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
            let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            
            //Validate email
            if emailPred.evaluate(with: email) == false{
                errorMessage = "Please enter a valid email id and try again"
            }
            //Check password count
            else if password.count < 8 {
                errorMessage = "Password must contain atleast 8 characters"
            }
            //Validate password strength
            else if passwordPred.evaluate(with: reEnterPassword) == false{
                errorMessage = "Password must contain atleast one uppercase character, one lower case character, one special character and one number"
            }
        }
        return errorMessage
    }
    
    //MARK:- Login Validation
    func validateLogin(withEmail email: String, password: String) -> String{
        var errorMessage = ""
        
        if email == "" || password == ""{
            errorMessage = "Cannot leave any field empty"
        }
        else{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
            let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            
            //Validate email
            if emailPred.evaluate(with: email) == false{
                errorMessage = "Please enter a valid email id and try again"
            }
            //Check password count
            else if password.count < 8 {
                errorMessage = "Password must contain atleast 8 characters"
            }
            //Validate password strength
            else if passwordPred.evaluate(with: password) == false{
                errorMessage = "Password must contain atleast one uppercase character, one lower case character, one special character and one number"
            }
        }
        return errorMessage
    }
    //MARK:- Forgot Password Validation
    func validateForgotPassword(withEmail email: String) -> String{
        var errorMessage = ""
        
        if email == ""{
            errorMessage = "Cannot leave any field empty"
        }
        else{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            //Validate email
            if emailPred.evaluate(with: email) == false{
                errorMessage = "Please enter a valid email id and try again"
            }
        }
        return errorMessage
    }
}
