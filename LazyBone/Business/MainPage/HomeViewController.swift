//
//  HomeViewController.swift
//  LazyBone
//
//  Created by zx on 11/29/16.
//  Copyright © 2016 com. creation.lazybone. All rights reserved.
//

import UIKit
import iCarousel

class HomeViewController: UIViewController {
	
	@IBOutlet weak var iCarouselView: iCarousel!
	
	override func awakeFromNib() {
		super.awakeFromNib()

	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension HomeViewController: iCarouselDelegate {
    
}

extension HomeViewController: iCarouselDataSource {
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        return UIView()
    }
}
