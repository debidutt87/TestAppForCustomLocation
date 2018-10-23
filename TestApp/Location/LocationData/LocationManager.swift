


import Foundation

class LocationManager: NSObject {
    var locationList : [Location] = []
    override init() {
         locationList = (DataManager.loadData(key: storeLocationData) as? LocationList)?.locList ?? [Location]()
    }
    
     //MARK: Geo Location Finder Method
    /*.... Find the location of provided address......*/
    func getGeoLocation(location:String,successHandler: @escaping (Bool) -> Void, failureHandler: @escaping (LocationValidationError) ->Void){
        LocationFinder.findLocation(locationName: location, successHandler: {(location) -> Void in
            // Store Data
            self.storeData(location: location)
            successHandler(true)
        }, failureHandler: {(error) -> Void in
            failureHandler(error)
        })
    }
    
    //MARK: Saving and retriving Data
     /*.... Storing Data.....*/
    func storeData(location:Location){
            locationList.insert(location, at: 0)
            let storedData = LocationList(locList: locationList)
            DataManager.saveData(data: storedData,key: storeLocationData)
    }
 
    /*.... Loading Data.....*/
    func getStoreData() ->[Location]?{
        return locationList
    }
    
    /*.... Modifying Data.....*/
    func storeModifiedData(list : [Location]){
        let storedData =  LocationList(locList: list)
        DataManager.saveData(data: storedData,key: storeLocationData)
    }
}
