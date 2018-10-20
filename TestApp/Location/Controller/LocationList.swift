//
//  LocationList.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit

class LocationList: NSObject,NSCoding {
    var locList = [Location]()
    
    init(locList:[Location]) {
        self.locList = locList
    }
    
    required init(coder aDecoder : NSCoder) {
        if let list = aDecoder.decodeObject(forKey: locListKey) as? [Location] {
            locList = list
            }
      }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(locList, forKey: locListKey)
    }
}
