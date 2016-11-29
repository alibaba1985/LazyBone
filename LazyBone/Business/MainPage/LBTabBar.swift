//
//  LBTabBar.swift
//  LazyBone
//
//  Created by zx on 11/29/16.
//  Copyright © 2016 com. creation.lazybone. All rights reserved.
//

import UIKit

class LBTabBar: UIView {
	var tabBarItems: [LBTabBarItem]
	init(tabBarItems: [LBTabBarItem]) {
		self.tabBarItems = tabBarItems
		super.init(frame: .zero)
		setup()
	}
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup() {
		for tabBarItem in tabBarItems {
			addSubview(tabBarItem)
		}
	}
}

class LBTabBarItem: UIButton {
	var title: String
	var color: UIColor
	var selectedColor: UIColor
	var action: (LBTabBarItem) -> ()
	init(title: String, color: UIColor, selectedColor: UIColor, action: @escaping (LBTabBarItem) -> ()) {
		self.title = title
		self.color = color
		self.selectedColor = selectedColor
		self.action = action
		super.init(frame: .zero)
		setup()
	}
    
	func setup() {
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(color, for: .selected)
        addTarget(self, action: #selector(LBTabBarItem.buttonPressed), for: .touchUpInside)
	}
    
    func buttonPressed() {
        isSelected = !isSelected
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
