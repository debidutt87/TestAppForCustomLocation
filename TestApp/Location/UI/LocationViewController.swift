
import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var locationTableView: UITableView!
    var customLocations : LocationList?
    var customLocationsList : [Location] = []
    
    //MARK: Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         customLocations = DataManager.loadData(key: storeLocationData) as? LocationList
        customLocationsList = customLocations?.locList ?? [Location]()
        let leftBtn = UIBarButtonItem(title: NSLocalizedString(editBtnTitle, comment: ""), style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.leftBarButtonItem = leftBtn
        locationTableView.reloadData()
    }
    
   /*..... Show Editing method ...*/
  @objc  func showEditing()
    {
        locationTableView.setEditing(!locationTableView.isEditing, animated: true)
        if locationTableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString(doneBtnTitle, comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(LocationViewController.showEditing))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: editBtnTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(LocationViewController.showEditing))
        }
    }

}

extension LocationViewController : UITableViewDelegate,UITableViewDataSource {
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return customLocationsList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! LocationCell
        let custLoc = customLocationsList[indexPath.row] as Location
        cell.locationName.text = custLoc.locationName.firstUppercased
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      let custLoc = customLocationsList[indexPath.row] as Location
       openWikiAppThroughDeepLinking(customLocation: custLoc)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            customLocationsList.remove(at: indexPath.row)
            LocationManager().storeModifiedData(list: customLocationsList)
            locationTableView.deleteRows(at: [indexPath], with: .left)
         }
    }
    
    
}

extension LocationViewController {
    //MARK: Deep Linking
    func openWikiAppThroughDeepLinking(customLocation:Location?){
        if let custLoc = customLocation {
            self.performDeepLinking(urlScheme: urlScheme, latitude: custLoc.latitude, longitude: custLoc.longitude)
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

