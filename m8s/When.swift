//
//  When.swift
//  m8s
//
//  Created by George Allen on 04/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

/**
 A when object houses the data for the when page
 This data consists of a description (eg 'TODAY' or 'TOMORROW') and a link to an image
 The image is used purely on the UI in particular in the when collection view
 */
class When: Entity {
    
    /**
     Description of the when item. E.g 'TODAY'
    */
    var description: String
    
    /**
     Foreign key to the image
     */
    var imageId: Int
    
    /**
     Creates a new When item with default values
     */
    override init() {
        self.imageId = 0
        self.description = ""
        super.init()
    }
}