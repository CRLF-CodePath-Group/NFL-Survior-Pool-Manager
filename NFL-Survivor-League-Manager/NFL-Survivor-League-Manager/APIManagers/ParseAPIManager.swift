//
//  ParseAPIManager.swift
//  NFL-Survivor-League-Manager
//
//  Created by Jacob Frick on 11/25/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import Foundation
import Parse

class ParseAPIManager {
    static func logInUser(_ username: String, _ password: String, completion: @escaping(User?, Error?) -> ()) {
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if let user = user {
                completion(user as? User, nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    static func signUpUser(_ username: String, password: String, _ email: String, completion: @escaping(User?, Error?) -> ()) {
        let user = User()
        user.username = username
        user.email = email
        user.password = password
        user.initUserInfo()
        user.signUpInBackground { (success, error) in
            if let error = error {
                completion(nil, error)
                print(error.localizedDescription)
            } else if success {
                completion(user, nil)
            }
            
        }
    }
}
