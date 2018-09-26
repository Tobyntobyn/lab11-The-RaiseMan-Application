//
//  Person.swift
//  RaiseMan
//
//  Created by Tobyn Packer on 9/26/18.
//  Copyright © 2018 Tobyn Packer. All rights reserved.
//

import Foundation

class Person: NSObject {
    var personName:String = "New Person"
    var expectedRaise:Float = 0.05
    
    override func setNilValueForKey(_ key: String) {
        if key == "expectedRaise" {
            expectedRaise = 0.0
        } else {
            super.setNilValueForKey(key)
        }
    }
}
