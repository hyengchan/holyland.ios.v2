//
//  UITextField+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/18.
//

import UIKit

extension UITextField {
    func changeBorder(color: UIColor) {
        let color = color.cgColor
        layer.sublayers?.first?.backgroundColor = color
    }
    
    func changeText(color: UIColor) {
        textColor = color
    }
    
    func changeTextAndBorder(color: UIColor) {
        changeText(color: color)
        changeBorder(color: color)
    }
}

extension UITextField {
    
    func addBottomBorder(width: CGFloat, height: CGFloat, color: UIColor?, leftPadding: CGFloat) {
        let leftPadding: CGFloat = leftPadding
        addBorderUtility(x: -leftPadding, y: height, width: width, height: 1, color: color)
    }
    
    private func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor?) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }

    func changeBottomBorder(color: UIColor?) {
        let color = color?.cgColor
        layer.sublayers?.first?.backgroundColor = color
    }
    
    func changeTextBottomBorder(color: UIColor?) {
        self.textColor = color
        
        let color = color?.cgColor
        layer.sublayers?.first?.backgroundColor = color
    }
}
