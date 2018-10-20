//
//  AddLocationViewController.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-19.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    var locationManager: LocationManager?
    var indicator:ProgressIndicator?
    @IBOutlet weak var locationTxtFld: UITextField!
 
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager()
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: indicatorMsg)
        self.view.addSubview(indicator!)
    }

}

extension AddLocationViewController {
     //MARK:Button Pressed Method
    /*......... Method is called when add button is pressed */
    @IBAction func addBtnPressed(_ sender: Any) {
        if let locationName = locationTxtFld.text {
            indicator?.start()
           self.getGeoLocation(location: locationName)
        }
    }
    
    func getGeoLocation(location:String){
        locationManager?.getGeoLocation(location: location, successHandler: { (result) -> Void in
            self.indicator?.stop()
            self.navigationController?.popViewController(animated: true)
        }, failureHandler: { (error) -> Void in
            self.indicator?.stop()
            switch(error as! LocationValidationError) {
            case .InvalidLocation:
                self.showAlert(errorMsg: invalidLocation)
            case .EmptyLocation:
                self.showAlert(errorMsg: emptyLocation)
            }
        })
    }
    
    //MARK:Show Alert
    func showAlert(errorMsg:String){
        let alert = UIAlertController(title: errotTitle, message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Okay, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
