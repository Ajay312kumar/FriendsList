//
//  Model.swift
//  FriendList
//
//  Created by Ajay Kumar on 04/03/24.
//

import Foundation
import UIKit

struct Friend {
    
    let firstName: String
    let lastName: String
    let contact: String
    var profilePicture: UIImage?
    
    static func defaultFriendList() -> [Friend] {
        
        var friendList = [Friend]()
        friendList.append(Friend(firstName: "Ajay", lastName: "Kumar", contact: "7894561234", profilePicture: UIImage(named: "puppy")))
    
        return friendList
    }
    
}
