

import UIKit
import Foundation

let leftMargin  = 150
let topMargin  = 25
let width = 300
let height = 50
let leadingMarging = 30
let activityWidth = 20
let cornerRadius = 15
let zero = 0
let alphaValue = 0.8
let activitleadingVal = 6

class ProgressIndicator: UIView {
    
    var indicatorColor:UIColor
    var loadingViewColor:UIColor
    var loadingMessage:String
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    init(inview:UIView,loadingViewColor:UIColor,indicatorColor:UIColor,msg:String){
        
        self.indicatorColor = indicatorColor
        self.loadingViewColor = loadingViewColor
        self.loadingMessage = msg
        super.init(frame: CGRect(x: inview.frame.midX - CGFloat(leftMargin), y: inview.frame.midY - CGFloat(topMargin), width: CGFloat(width), height: CGFloat(height)))
        initalizeCustomIndicator()
        
    }
    convenience init(inview:UIView) {
        
        self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: "Loading..")
    }
    convenience init(inview:UIView,messsage:String) {
        
        self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: messsage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalizeCustomIndicator(){
        
        messageFrame.frame = self.bounds
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.tintColor = indicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: self.bounds.origin.x + CGFloat(activitleadingVal), y: CGFloat(zero), width: CGFloat(activityWidth), height: CGFloat(height))
        print(activityIndicator.frame)
        let strLabel = UILabel(frame:CGRect(x: self.bounds.origin.x + CGFloat(leadingMarging), y: CGFloat(zero), width: self.bounds.width - (self.bounds.origin.x + CGFloat(leadingMarging)) , height:  CGFloat(height)))
        strLabel.text = loadingMessage
        strLabel.adjustsFontSizeToFitWidth = true
        strLabel.textColor = UIColor.white
        messageFrame.layer.cornerRadius = CGFloat(cornerRadius)
        messageFrame.backgroundColor = loadingViewColor
        messageFrame.alpha = CGFloat(alphaValue)
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(strLabel)
        
        
    }
    
    func  start(){
        //check if view is already there or not..if again started
        if !self.subviews.contains(messageFrame){
            activityIndicator.startAnimating()
            self.addSubview(messageFrame)
        }
    }
    
    func stop(){
        
        if self.subviews.contains(messageFrame){
            activityIndicator.stopAnimating()
            messageFrame.removeFromSuperview()
            
        }
    }
}
