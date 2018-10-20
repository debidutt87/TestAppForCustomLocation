//
//  Utility.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-20.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import Foundation



extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
