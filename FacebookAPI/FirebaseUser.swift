//
//  FirebaseUser.swift
//  FacebookAPI
//
//  Created by Hyung Jip Moon on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseUser
{
    static let sharedInstance = FirebaseUser()
    var current: FIRUser?
}
