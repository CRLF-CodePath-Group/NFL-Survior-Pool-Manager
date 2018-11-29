//
//  Pick.swift
//  NFL-Survivor-League-Manager
//
//  Created by Jacob Frick on 11/28/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import Foundation

class Pick: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "Pick"
    }
    
    var username = String()
    var teamPicked = Team.self
    
    init(_ username: String, _ teamPicked: Team.Type) {
        self.username = username
        self.teamPicked = teamPicked
        super.init()
    }
}
