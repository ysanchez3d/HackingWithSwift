//
//  Picture.swift
//  Picture-Perfect
//
//  Created by Yandri Sanchez on 12/30/20.
//

import UIKit

class Picture: Codable {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
