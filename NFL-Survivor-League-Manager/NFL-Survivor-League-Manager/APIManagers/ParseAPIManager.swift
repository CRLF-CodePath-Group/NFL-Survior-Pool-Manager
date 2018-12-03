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
    static func createNewLeague(_ owner: String, _ leagueName: String, completion: @escaping(League?, Error?) -> ()) {
        let league = League()
        
        league.owner = owner
        league.leagueName = leagueName
        league.hasStarted = false
        league.currentWeek = 1
        league.aliveMembers = [String]()
        league.deadMembers = [String]()
        league.initLeague(leagueName, owner)
        league.saveInBackground() {
            (success, error) in
            if success {
                completion(league, nil)
            } else if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            
        }
    }
    static func getLeagueById(_ ids: [String], completion: @escaping([League]?, Error?) -> ()) {
        let query = PFQuery(className: "League")
        query.whereKey("objectId", containedIn: ids)
        query.findObjectsInBackground { (leagues, error) in
            if let leagues = leagues {
                completion(leagues as? [League], nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    static func findUserByUsername(_ username: String, completion: @escaping(User?, Bool?) -> ()) {
        let query = PFUser.query()
        query?.whereKey("username", contains: username)
        query?.findObjectsInBackground(block: { (users, error) in
            if users != nil && (users?.count)! > 0{
                var found = false
                if let users = users as? [User] {
                    for user in users {
                        if username == user.username {
                            found = true
                            completion(user, true)
                        }
                    }
                    if !found {
                        completion(nil, false)
                    }
                }
            } else{
                //print(error.localizedDescription)
                completion(nil, false)
            }
        })
    }
}
