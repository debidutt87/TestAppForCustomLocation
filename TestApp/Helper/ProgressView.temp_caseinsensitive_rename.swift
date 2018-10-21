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
   
    func initWithTitle(title :String?) {
        self.msgLbl.text = title
        startAnimating()
    }
    
    func stopAnimating() {
        self.isHidden =  true
        self.progressIndicator.stopAnimating()
    }
    
    func startAnimating() {
        self.isHidden =  false
        self.progressIndicator.startAnimating()
    }
}
