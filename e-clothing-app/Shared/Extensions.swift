//
//  Extensions.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-18.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Extensions{
    static let customFR = "Raleway-Regular"
    static let customFB = "Raleway-Bold"
    static let customFSB = "Raleway-SemiBold"
}


let ref = Firestore.firestore()



func fetchUser(completion: @escaping (UserModel) -> ()){
    let uid = Auth.auth().currentUser!.uid
    ref.collection("Users").document(uid).getDocument{ (doc, err) in
        guard let user = doc else { return }
    
        let email = user.data()?["email"] as! String
         
        DispatchQueue.main.async {
            completion(UserModel(email: email))
        }
    }
}
