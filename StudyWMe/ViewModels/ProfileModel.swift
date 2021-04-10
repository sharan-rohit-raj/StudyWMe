//
//  ProfileModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-29.
//

import Foundation
import Firebase

class ProfileModel: ObservableObject {
    @Published var firstName: String = Auth.auth().currentUser?.displayName ?? ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    
    private var db = Firestore.firestore()
    
    func addProfileData(userUID: String, firstName: String, lastName: String, phoneNumber: String) {
        
            let profileData: [String: String] = ["firstName": firstName,
                                                 "lastName": lastName,
                                                 "phoneNumber": phoneNumber]
            //Adds profileData to firebase
        let _ =  db.collection("students").document(userUID).setData(profileData)

    }
}
