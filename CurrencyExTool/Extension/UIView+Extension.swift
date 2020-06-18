//
//  UIView+Extension.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
extension UIView{

    @IBInspectable var cornerRadius: CGFloat
        {
        get { return layer.cornerRadius }
        set
        {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }


    @IBInspectable var borderWidth: CGFloat
        {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }


    @IBInspectable var borderColor: UIColor?
        {
        get
        {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}

protocol NibMakeInstantiable {}

extension UIView : NibMakeInstantiable{}

extension NibMakeInstantiable where Self : UIView{
    static func instanceFromNib() -> Self{
        if let view = Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as? Self{
            return view
        }else{
            assert(false," The nib name \(self) is not found")
            return Self()
        }
    }
}
