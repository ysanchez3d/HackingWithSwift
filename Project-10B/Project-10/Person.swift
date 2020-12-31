//
//  Person.swift
//  Project-10
//
//  Created by Yandri Sanchez on 12/27/20.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
