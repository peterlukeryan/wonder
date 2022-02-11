//
//  IntroViewController.swift
//  wonderTech
//
//  Created by Mac User on 7/3/18.
//  Copyright © 2018 Mac User. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var introIcon: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introIcon.layer.cornerRadius = 15
        introIcon.clipsToBounds = true
        
        introIcon.layer.borderColor = UIColor.black.cgColor
        introIcon.layer.borderWidth = 2
        

       
    }

 
}
