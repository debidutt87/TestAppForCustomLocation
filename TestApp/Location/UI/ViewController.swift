//
//  ViewController.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationTableView: UITableView!
    var customLocations : LocationList?
    var customLocationsList : [Location]?
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         customLocations = DataManager.loadData(key: storeLocationData) as? LocationList
        customLocationsList = customLocations?.locList ?? [Location]()
        locationTableView.reloadData()
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return customLocationsList!.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let custLoc = customLocationsList![indexPath.row] as Location
        cell.locationName.text = custLoc.locationName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      let custLoc = customLocationsList![indexPath.row] as Location
       openWikiAppThroughDeepLinking(customLocation: custLoc)
    }
    
    
}

extension ViewController {
    
    func openWikiAppThroughDeepLinking(customLocation:Location?){
        if let custLoc = customLocation {
            self.performDeepLinking(urlScheme: urlScheme, latitude: custLoc.latitude!, longitude: custLoc.longitude!)
        }
    }
    
    func performDeepLinking(urlScheme:String,latitude:String,longitude:String){
        
        if let url = self.getURL(urlScheme: urlScheme, latitude: latitude, longitude: longitude)
        {
            if UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else
            {
                print("Not able to open \(url)")
            }
        }
    }
    
    func getURL(urlScheme:String,latitude:String,longitude:String) -> URL?{
        let custURL : String = urlScheme + latitude + "&" + longitude
        return URL(string: custURL) ?? nil
    }
}
