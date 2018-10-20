//
//  Location.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit

class Location: NSObject, NSCoding{
  
    
    var locationName : String?
    var latitude : String?
    var longitude : String?
    
    init(locationName:String,latitude:String,longitude:String) {
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init(coder aDecoder : NSCoder) {
        locationName = aDecoder.decodeObject(forKey: locationNameKey) as? String ?? ""
        latitude = aDecoder.decodeObject(forKey: latitudeKey) as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: longitudeKey) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(locationName, forKey: locationNameKey)
        aCoder.encode(latitude, forKey: latitudeKey)
        aCoder.encode(longitude, forKey:longitudeKey)
    }
}
