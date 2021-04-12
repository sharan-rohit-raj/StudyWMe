//
//  ProfileModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-29.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ProfileModel: ObservableObject {
    private var nameLimit = 30
    @Published var firstName: String = Auth.auth().currentUser?.displayName ?? "" {
        didSet {
            if firstName.count > nameLimit {
                firstName = String(firstName.prefix(nameLimit))
            }
        }
    }
    @Published var lastName: String = "" {
        didSet {
            if lastName.count > nameLimit {
                lastName = String(lastName.prefix(nameLimit))
            }
        }
    }
    
    @Published var phoneNumber: String = ""
    private var listener: ListenerRegistration?
    
    private var db = Firestore.firestore()
    
    /// Saves Profile data in firebase
    /// - Parameters:
    ///   - userUID: UID of the student
    ///   - firstName: First name of the student
    ///   - lastName: Last name of the student
    ///   - phoneNumber: Phonenumber of the student
    func addProfileData(userUID: String, firstName: String, lastName: String, phoneNumber: String) {
        
            let profileData: [String: String] = ["firstName": firstName,
                                                 "lastName": lastName,
                                                 "phoneNumber": phoneNumber]
            //Adds profileData to firebase
        let _ =  db.collection("students").document(userUID).setData(profileData)

    }
    
    /// Fetches Profile data info aboout students
    /// - Parameter userUID: UID of the student
    func fetchProfileData(userUID: String) {
        listener = db.collection("students").document(userUID).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            self.firstName = data["firstName"] as? String ?? ""
            self.lastName = data["lastName"] as? String ?? ""
            self.phoneNumber = data["phoneNumber"] as? String ?? ""
        }
    }
    
    /// Detach the listener when you dont need real time updates
    func detachProfileDataListener() {
        if let listenerRegistration  = listener {
            listenerRegistration.remove()
        }
    }
}
