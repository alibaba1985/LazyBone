//
//  UIButton+Localize.swift
//  localizeDemo
//
//  Created by admin on 12/14/15.
//  Copyright © 2015 __ASIAINFO__. All rights reserved.
//

import UIKit

extension UIButton {

    var ailButtonNormalTitle: String? {
        get {
            return title(for: UIControlState.normal)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.normal)
        }
    }

    var ailButtonHighlightedTitle: String? {
        get {
            return title(for: UIControlState.highlighted)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.highlighted)
        }

    }
    var ailButtonDisabledTitle: String? {
        get {
            return title(for: UIControlState.disabled)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.disabled)
        }
    }
    var ailButtonSelectedTitle: String? {
        get {
            return title(for: UIControlState.selected)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.selected)
        }
    }
    var ailButtonApplicationTitle: String? {
        get {
            return title(for: UIControlState.application)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.application)
        }
    }

    var ailButtonReservedTitle: String? {
        get {
            return title(for: UIControlState.reserved)
        }
        set {
            setTitle(newValue?.localized, for: UIControlState.reserved)
        }
    }
}
