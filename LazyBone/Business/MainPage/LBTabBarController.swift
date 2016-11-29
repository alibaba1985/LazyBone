//
//  LBTabBarController.swift
//  LazyBone
//
//  Created by zx on 11/29/16.
//  Copyright © 2016 com. creation.lazybone. All rights reserved.
//

import UIKit

class LBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBar.isHidden = true
        self.selectedIndex = 1
//        self.delegate = self
//        self.view.addSubview(customTabBar)
    }
}
