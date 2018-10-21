


import Foundation

class DataManager: NSObject {
    //MARK:Storing & Retriving Data
    /*....... Storing Data ........*/
    /*Param data could be accepted in any format
     key could be keyName to be used to store and retrive */
    class  func saveData(data : AnyObject,key:String){
        let defaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: data)
        defaults.set(data,forKey: key)
        defaults.synchronize()
    }
    
    class func loadData(key:String) -> AnyObject? {
    if let data = UserDefaults.standard.object(forKey: key){
        let storedData =  NSKeyedUnarchiver.unarchiveObject(with: (data as? Data)!)
        return storedData as AnyObject
    }
    return nil
    }
}
