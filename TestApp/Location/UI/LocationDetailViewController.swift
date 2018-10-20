//
//  LocationDetailViewController.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var customLocation : Location?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocationDeatil
        let wikiBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openWikiApp))
        self.navigationItem.rightBarButtonItem = wikiBtn
        self.openMap()
    }
    
    @objc func openWikiApp(sender: AnyObject){
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

extension LocationDetailViewController {
    func openMap(){
        if let custLoc = customLocation {
            if let lat = custLoc.latitude, let long = custLoc.longitude{
                let loc = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
               centerMapOnLocation(location: loc)
               }
        }
}
    
    func centerMapOnLocation(location: CLLocation) {
         let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
