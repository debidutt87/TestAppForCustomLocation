//
//  LocationFinder.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit
import Foundation
import MapKit

enum LocationValidationError : Error {
    case InvalidLocation
    case EmptyLocation
}

class LocationFinder: NSObject {
    
/* Method to be used to find out geolocation of address provided*/
/*Param
LocationName is used for address to be found
SuccessHandler to be sent as location model
Failure Handler to be send as error found whild validation of address provided
*/
 
    class  func findLocation(locationName:String,successHandler: @escaping (Location) -> Void, failureHandler: @escaping (Error) ->Void){
        if locationName == " " || locationName.count < 1 {
            failureHandler(LocationValidationError.EmptyLocation)
        }else{
            let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(locationName) { (placemarks, error) -> Void in
                    if (error != nil) {
                        failureHandler(LocationValidationError.InvalidLocation)
                    }
                    if let firstPlacemark = placemarks?[0] {
                        let pm = MKPlacemark(placemark: firstPlacemark)
                        let location = Location(locationName: locationName, latitude:String(pm.coordinate.latitude), longitude: String(pm.coordinate.longitude))
                        successHandler(location)
                    }
                }
            }
        }

}
