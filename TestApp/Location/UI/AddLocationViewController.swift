

import UIKit

class AddLocationViewController: UIViewController {
    var locationManager: LocationManager?
    @IBOutlet weak var locationTxtFld: UITextField!
 
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager()
        self.addProgressIndicatorWithBackground(text: NSLocalizedString(indicatorMsg, comment: ""))
    }

}

extension AddLocationViewController {
     //MARK:Button Pressed Method
    /*......... Method is called when add button is pressed */
    @IBAction func addBtnPressed(_ sender: Any) {
        if let locationName = locationTxtFld.text {
            self.showProgressView()
           self.getGeoLocation(location: locationName)
        }
    }
    
    func getGeoLocation(location:String){
        locationManager?.getGeoLocation(location: location, successHandler: { (result) -> Void in
            self.hideProgressView()
            self.navigationController?.popViewController(animated: true)
        }, failureHandler: { (error) -> Void in
             self.hideProgressView()
            switch(error) {
            case .InvalidLocation:
                self.showAlert(errorMsg: NSLocalizedString(invalidLocation, comment: ""))
            case .EmptyLocation:
                self.showAlert(errorMsg: NSLocalizedString(emptyLocation, comment: ""))
            }
        })
    }
    
    //MARK:Show Alert
    func showAlert(errorMsg:String){
        let alert = UIAlertController(title: NSLocalizedString(errotTitle, comment: ""), message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(Okay, comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
