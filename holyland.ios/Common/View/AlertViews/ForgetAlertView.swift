//
//  ForgetAlertView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

class ForgetAlertView: AlertView {
    
    override var message: String? {
        get {
            return self.messageLabel.text
        }
        set {
            self.messageLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "imgCharactersSet")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(300)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.width.equalTo(149)
            $0.height.equalTo(90)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(Constants.Design.basicPadding)
            $0.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
        }
        
        okayButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Constants.Design.basicPadding)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        grayBar.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-54)
        }
    }
}
