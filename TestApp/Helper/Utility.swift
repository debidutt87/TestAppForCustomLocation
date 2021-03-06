

import Foundation
import UIKit


extension StringProtocol {
    /*.. Making first character of string in Caps ....*/
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
  var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}


public extension UIViewController {
    //MARK: Custom Progress Indicator View
    /*.. Adding Progress view on main View....*/
    public func addProgressIndicatorWithBackground(text : String){
        guard let nibView =  Bundle.main.loadNibNamed(progressView, owner: self, options: nil)?[0] as? ProgressView else {return}
        nibView.initWithTitle(title: text)
        nibView.tag = nibTagged
         self.view.addSubview(nibView)
        nibView.bringSubview( toFront: (nibView.progressIndicator))
        nibView.bringSubview( toFront: (nibView.msgLbl))
       nibView.translatesAutoresizingMaskIntoConstraints =  false
        nibView.isHidden =  true
        let xConstraint = NSLayoutConstraint(item: nibView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: nibView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(xConstraint)
        self.view.addConstraint(yConstraint)
        self.view.layoutIfNeeded()
    }
    
     /*.. Start Progress Indicator ......*/
    public func showProgressView(){
        self.view.viewWithTag(nibTagged)?.isHidden = false
    }
    
     /*.. Stop Progress Indicator ......*/
    public func hideProgressView() {
        self.view.viewWithTag(nibTagged)?.isHidden =  true
    }
}

