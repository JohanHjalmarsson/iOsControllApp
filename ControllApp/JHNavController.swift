//
//  JHNavController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-29.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class JHNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
    }
    
}
