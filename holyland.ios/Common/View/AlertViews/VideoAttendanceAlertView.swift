//
//  VideoAttendanceAlertView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit
import SnapKit

class VideoAttendanceAlertView: AlertView {
    
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
        
        imageView.image = Asset.Assets.icAmen100.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(270)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        grayBar.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-54)
        }
        
        okayButton.snp.makeConstraints {
            $0.top.equalTo(grayBar.snp.bottom).offset(Constants.Design.basicPadding)
            $0.bottom.leading.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
            $0.centerX.equalToSuperview()
        }
    }
}
