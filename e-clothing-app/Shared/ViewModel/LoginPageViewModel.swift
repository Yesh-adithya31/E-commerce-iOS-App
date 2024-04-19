//
//  LoginPageViewModel.swift
//  e-clothing-app
//
//  Created by Ovini on 2024-03-18.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class LoginPageViewModel: ObservableObject {
    // Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPasword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_password: String = ""
    @Published var showReEnterPasword: Bool = false
    
    @Published var showToast: Bool = false
    @Published var showErrorMessage: String = ""
    
    //Login Status
    @AppStorage("log_status") var log_status: Bool = false
    let defaults = UserDefaults.standard
    let ref = Firestore.firestore()
    
    func verify(){
        if registerUser {
            if self.email != "" && self.password != "" {
                if self.password == self.re_Enter_password {
                    createNewAccount()
                }else{
                    self.showErrorMessage = "Password mismatch"
                    self.showToast.toggle()
                }
            } else {
                self.showErrorMessage = "Please Fill the all the Fields properly"
                self.showToast.toggle()
            }
        }else{
            if self.email != "" && self.password != "" {
                loginWithEmail();
            } else {
                self.showErrorMessage = "Please Fill the all the Fields properly"
                self.showToast.toggle()
            }
        }

    }
    
    func loginWithEmail(){
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (res , err)  in
            if err != nil {
                self.showToast.toggle()
                self.showErrorMessage = err!.localizedDescription
            }else{
                
                fetchUser() { userDetails in
                    withAnimation {
                        self.defaults.setValue(userDetails.email, forKey: "userEmail")
                        self.log_status = true
                    }

                }

            }
        }
    }
    
    func createNewAccount(){
        Auth.auth().createUser(withEmail: self.email, password: self.password) { (res , err)  in
            if err != nil {
                self.showToast.toggle()
                self.showErrorMessage = err!.localizedDescription
            }else{
                let uid = res?.user.uid
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: Date())
                
                
                self.ref.collection("Users").document(uid!).setData([
                    "uid" : uid as Any,
                    "email" : self.email,
                    "dateCreated" : dateString
                    
                ]) { (err) in
                    if err != nil {
                        self.showToast.toggle()
                        self.showErrorMessage =  err!.localizedDescription
                    }else{
                        self.showToast.toggle()
                        self.showErrorMessage = "Registered Successfully"
                        self.email = ""
                        self.password = ""
                        self.re_Enter_password = ""
                    }
                }
            }
        }
    }

    
    // Forgetpassword action call
    func forgetPassword(){
        
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            withAnimation {
                log_status = false
            }
            print("User logged out successfully.")
            // Navigate to the login screen or perform any other action after logout
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }

    }
}

