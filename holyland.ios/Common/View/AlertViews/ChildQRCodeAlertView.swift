//
//  ChildQRCodeAlertView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

class ChildQRCodeAlertView: AlertView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(328)
        }
        
        let okayButtonHeight = 22
        okayButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Constants.Design.basicPadding)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(okayButtonHeight)
        }
        
        let grayBarHeight = 1
        grayBar.snp.makeConstraints {
            $0.height.equalTo(grayBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-54)
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(180)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-(okayButtonHeight + grayBarHeight))
        }
    }
    
    func setup(with qrcodeImage: UIImage) {
        imageView.image = qrcodeImage
    }
}
