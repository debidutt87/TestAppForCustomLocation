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
        let leftBtn = UIBarButtonItem(title: editBtnTitle, style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.leftBarButtonItem = leftBtn
        locationTableView.reloadData()
    }
    
  @objc  func showEditing()
    {
        locationTableView.setEditing(!locationTableView.isEditing, animated: true)
        if locationTableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: doneBtnTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.showEditing))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: editBtnTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.showEditing))
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! LocationCell
        let custLoc = customLocationsList![indexPath.row] as Location
        cell.locationName.text = custLoc.locationName
        cell.locationName.text?.capitalizeFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      let custLoc = customLocationsList![indexPath.row] as Location
       openWikiAppThroughDeepLinking(customLocation: custLoc)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            customLocationsList?.remove(at: indexPath.row)
            LocationManager().storeModifiedData(list: customLocationsList!)
            self.locationTableView.reloadData()
        }
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

