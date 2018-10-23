//
//  ProgressVIew.swift
//  TestApp
//
//  Created by Mukesh Kumar on 2018-10-22.
//  Copyright © 2018 Mukesh Kumar. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
   
    /* Initiate View with title..*/
    func initWithTitle(title :String?) {
        self.msgLbl.text = title
        startAnimating()
    }
    
    /* Stop Animation */
    func stopAnimating() {
        self.isHidden =  true
        self.progressIndicator.stopAnimating()
    }
    
     /* Start Animation */
    func startAnimating() {
        self.isHidden =  false
        self.progressIndicator.startAnimating()
    }
}
