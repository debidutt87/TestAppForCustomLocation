//
//  DataManager.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//


import Foundation

class DataManager: NSObject {
    
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
