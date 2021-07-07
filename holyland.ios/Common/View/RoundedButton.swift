//
//  RoundedButton.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/18.
//

import UIKit

class RoundedButton: UIButton {
    
    var enabledTitleColor = UIColor.white {
        didSet {
            self.setTitleColor(enabledTitleColor, for: .normal)
        }
    }
    var enabledBackgroundColor = Asset.Color.main.color {
        didSet {
            self.backgroundColor = enabledBackgroundColor
        }
    }
    var disableTitleColor = Asset.Color.gray5.color {
        didSet {
            self.setTitleColor(disableTitleColor, for: .disabled)
        }
    }
    var disabledBackgroundColor = Asset.Color.gray4.color {
        didSet {
            self.backgroundColor = disabledBackgroundColor
        }
    }
    
    var boaderColor = Asset.Color.main.color {
        didSet {
            self.layer.borderColor = boaderColor.cgColor
        }
    }
    
    var boaderWidth: CGFloat = 1.5 {
        didSet {
            self.layer.borderWidth = boaderWidth
        }
    }
    
    override var isEnabled: Bool {
        willSet {
            if newValue == false {
                self.setTitleColor(disableTitleColor, for: .disabled)
                self.backgroundColor = disabledBackgroundColor
            } else {
                self.setTitleColor(enabledTitleColor, for: .normal)
                self.backgroundColor = enabledBackgroundColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(enabledTitleColor, for: .normal)
        self.backgroundColor = enabledBackgroundColor
        self.titleLabel?.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 16)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
       layer.cornerRadius = frame.height / 2
    }
    
    func changeTitleFont(_ font: UIFont?) {
        self.titleLabel?.font = font
    }
    
    func addBoader(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func removeBoader() {
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
