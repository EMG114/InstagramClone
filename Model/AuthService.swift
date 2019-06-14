//
//  AuthService.swift
//  InstagramClone
//
//  Created by Erica on 5/7/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    

    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMesssage: String?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                onError(error?.localizedDescription)
                return
            }
           onSuccess()
        }
    }
    
    static func signUp(userName: String, email: String, password: String, imageData:Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMesssage: String?) -> Void ) {
       
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            let uid = result?.user.uid
            let storage = Storage.storage().reference().child("profile_image").child(uid!)

            storage.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    metadata?.storageReference?.downloadURL(completion: { (url, error) in
                        if error != nil {
                           onError(error?.localizedDescription)
                            return
                        }
                        let profileImageURL = url?.absoluteString
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users")
                        let newUserRef = usersReference.child(uid!)
                        newUserRef.setValue(["username": userName, "email": email, "profileImageUrl": profileImageURL!])
                    })
                })
            
            
        }
        
        onSuccess()
    }
    
}
