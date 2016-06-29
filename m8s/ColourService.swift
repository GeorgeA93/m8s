//
//  ColourService.swift
//  m8s
//
//  Created by George Allen on 29/06/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

private let _shared = ColourService()

class ColourService {
    class var shared: ColourService {
        return _shared
    }
    
    let DarkBlack: UIColor = UIColor(hex: "1D1D1D")
    let LightBlack: UIColor = UIColor(hex: "202020")
    let DarkWhite: UIColor = UIColor(hex: "B0B6BB")
    let LightWhite: UIColor = UIColor(hex: "E8ECEE")

    
    init() {
        
    }
}