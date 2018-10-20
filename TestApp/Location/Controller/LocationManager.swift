//
//  LocationManager.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//


import Foundation

class LocationManager: NSObject {
    var locationList : [Location]?
    override init() {
         locationList = (DataManager.loadData(key: storeLocationData) as? LocationList)?.locList ?? [Location]()
    }
    
    /*.... Find the location of provided address......*/
    func getGeoLocation(location:String,successHandler: @escaping (Bool) -> Void, failureHandler: @escaping (Error) ->Void){
        LocationFinder.findLocation(locationName: location, successHandler: {(location) -> Void in
            // Store Data
            self.storeData(location: location)
            successHandler(true)
        }, failureHandler: {(error) -> Void in
            failureHandler(error)
        })
    }
    
    //MARK: Saving and retriving Data
    func storeData(location:Location){
        guard var addressList = locationList else {
           locationList?.append(location)
            let storedData = LocationList(locList: locationList!)
            DataManager.saveData(data: storedData,key: storeLocationData)
            return
        }
            addressList.append(location)
            let storedData = LocationList(locList: addressList)
            DataManager.saveData(data: storedData,key: storeLocationData)
      }
 
    
    func getStoreData() ->[Location]?{
        return locationList
    }

}
