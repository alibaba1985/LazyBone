//
//  LBTabBar.swift
//  LazyBone
//
//  Created by zx on 11/29/16.
//  Copyright © 2016 com. creation.lazybone. All rights reserved.
//

import UIKit
import SnapKit

class LBTabBar: UIView {
	var tabBarItems: [LBTabBarItem] = []
	var selectedIndex = 0 {
		didSet {
			updateUI()
		}
	}
	var titles: [String]
	var colors: [UIColor]
	var didSelected: (LBTabBar) -> ()
	init(titles: [String], colors: [UIColor], didSelected: @escaping (LBTabBar) -> ()) {
		self.titles = titles
		self.colors = colors
		self.didSelected = didSelected
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup() {
		for (i, title) in titles.enumerated() {
			let color = colors[i]
			let item = LBTabBarItem(title: title, color: color)
			item.tag = i
			item.addTarget(self, action: #selector(LBTabBar.buttonPressed(sender:)), for: .touchUpInside)
			tabBarItems.append(item)
			addSubview(item)
		}
		
		let barHeight: CGFloat = 50.displayFrom1Scale()
		let margin: CGFloat = 3.displayFrom1Scale()
		let space: CGFloat = 12.32.displayFrom1Scale()
		var previousView: LBTabBarItem!
		
		for (i, tabBarItem) in tabBarItems.enumerated() {
			tabBarItem.snp.makeConstraints({ (make) in
				make.top.equalTo(self)
				if i == 0 {
					make.leading.equalTo(margin)
				} else {
					make.leading.equalTo(previousView.snp.trailing).offset(space)
					make.width.equalTo(previousView)
				}
				make.height.equalTo(barHeight)
				if i == tabBarItems.count - 1 {
					make.trailing.equalTo(self).offset(-margin)
				}
			})
			previousView = tabBarItem
		}
	}
	
	func buttonPressed(sender: LBTabBarItem) {
		selectedIndex = sender.tag
		updateUI()
        didSelected(self)
	}
	
	func updateUI() {
		for item in tabBarItems {
			item.isSelected = item.tag == selectedIndex
		}
	}
}

extension CGFloat {
	func displayFrom1Scale() -> CGFloat {
		let screen = UIScreen.main
		let displaySize: CGFloat = self * screen.bounds.size.width / 414;
		return displaySize;
	}
}

extension Double {
	func displayFrom1Scale() -> CGFloat {
		let screen = UIScreen.main
		let displaySize: CGFloat = CGFloat(self) * screen.bounds.size.width / 414;
		return displaySize;
	}
}

extension Int {
	func displayFrom1Scale() -> CGFloat {
		let screen = UIScreen.main
		let displaySize: CGFloat = CGFloat(self) * screen.bounds.size.width / 414;
		return displaySize;
	}
}

class LBTabBarItem: UIButton {
	var title: String
	var color: UIColor
	init(title: String, color: UIColor) {
		self.title = title
		self.color = color
		super.init(frame: .zero)
		setup()
	}
	
	override var isSelected: Bool {
		didSet {
			if isSelected {
				backgroundColor = color
			} else {
				backgroundColor = UIColor.clear
			}
		}
	}
	
	func setup() {
		setTitle(title, for: .normal)
		setTitleColor(UIColor.white, for: .selected)
		setTitleColor(color, for: .normal)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
