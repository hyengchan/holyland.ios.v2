//
//  UIView+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import UIKit

extension UIView {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func makeRounded() {
        makeRounded(radius: self.frame.height/2)
    }
    
    func makeRounded(radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeRounded(radius: CGFloat, at corners: CACornerMask) {
        makeRounded(radius: radius)
        self.layer.maskedCorners = corners
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func addTopBorder(width: CGFloat, height: CGFloat, color: UIColor) {
        addBorderUtility(potisionX: 0, positionY: 0, width: width, height: height, color: color)
    }
    
    private func addBorderUtility(potisionX: CGFloat, positionY: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: potisionX, y: positionY, width: width, height: height)
        layer.addSublayer(border)
    }
    
    var safeAreaTop: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
         }
         return 0
    }
    
    var safeAreaBottom: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
         }
         return 0
    }
    
    public func fadeInOut(duration: TimeInterval = 1.0,
                          delay: TimeInterval = 1.0,
                          completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        self.alpha = 1.0
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        self.alpha = 0.1
                       },
                       completion: { (finished) in
                        self.isHidden = finished
                        completion?(finished)
                       }
        )
    }
    
    public func fadeIn(duration: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        self.alpha = 0.1
        UIView.animate(withDuration: duration,
                       animations: {
                           self.alpha = 1.0
                       },
                       completion: completion)
    }
    
    public func fadeOut(duration: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                           self.alpha = 0.1
                       },
                       completion: { isFinished in
                           self.isHidden = isFinished
                           completion?(isFinished)
        })
    }
    
    func showAlertView(type: AlertType, completion: (() -> Void)? = nil) {
        let alertView = type.alertView
        alertView.frame = self.frame
        alertView.setDefaultBody(type: type)
        alertView.okayActionCompletion = completion
        self.addSubview(alertView)
    }
    
    // MARK: - ToastView
    func showToastView(message: String, frame: CGRect = .zero, type: ToastView.ToastType = .basic) {
        let frame = frame != .zero ? frame : {
            let offset: CGFloat = 6
            let defaultHeight: CGFloat = 56
            let frame = CGRect(x: offset,
                               y: self.frame.height - self.safeAreaInsets.bottom - offset - defaultHeight,
                               width: self.frame.width - offset * 2,
                               height: defaultHeight)
            return frame
        }()
        
        let toastView = ToastView(frame: frame, message: message, type: type)
        self.addSubview(toastView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                        toastView.alpha = 0
                    }, completion: {_ in
                        toastView.removeFromSuperview()
                    })
                })
    }
}
