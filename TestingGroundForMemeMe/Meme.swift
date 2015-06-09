//
//  Meme.swift
//  TestingGroundForMemeMe
//
//  Created by Colin Easter on 6/8/15.
//  Copyright (c) 2015 Colin Easter. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String!
    var bottomText: String!
    var cleanImage: UIImage!
    var memedImage: UIImage!
    init (textFromTop: String, textFromBottom: String, originalImage: UIImage, memedImage: UIImage){
        topText = textFromTop
        bottomText = textFromBottom
        cleanImage = originalImage
        self.memedImage = memedImage
    }
    
    
}