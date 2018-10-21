


import Foundation

class LocationManager: NSObject {
    var locationList : [Location]?
    override init() {
         locationList = (DataManager.loadData(key: storeLocationData) as? LocationList)?.locList ?? [Location]()
    }
    
     //MARK: Geo Location Finder Method
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
            locationList?.insert(location, at: 0)
            let storedData = LocationList(locList: locationList!)
            DataManager.saveData(data: storedData,key: storeLocationData)
            return
        }
        addressList.insert(location, at: 0)
            let storedData = LocationList(locList: addressList)
            DataManager.saveData(data: storedData,key: storeLocationData)
      }
 
    
    func getStoreData() ->[Location]?{
        return locationList
    }
    
    func storeModifiedData(list : [Location]){
        let storedData =  LocationList(locList: list)
        DataManager.saveData(data: storedData,key: storeLocationData)
    }
}
