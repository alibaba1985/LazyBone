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
		self.selectedIndex = 0
		let action: (LBTabBar) -> () = { [weak self] bar in
			self?.selectedIndex = bar.selectedIndex
		}
        
        let titles = [
            "首页",
            "我的学员",
            "个人信息"
        ]
        
        let colors = [
            UIColor(hexString: "#FF518B")!,
            UIColor(hexString: "#40D7FF")!,
            UIColor(hexString: "#A6F14E")!
        ]
        
        let tabBar = LBTabBar(titles: titles, colors: colors, didSelected: action)
        tabBar.selectedIndex = 0
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(view)
            make.height.equalTo(65.displayFrom1Scale())
        }
	}
}
