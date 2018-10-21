//
//  Utility.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-20.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import Foundation



extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
  var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}
