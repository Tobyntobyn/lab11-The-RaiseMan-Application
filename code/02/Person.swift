//
//  Person.swift
//  RaiseMan
//
//  Created by David Eyers on 28/09/16.
//  Checked for Xcode 8.3 / Swift 3.x in 2017.
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
