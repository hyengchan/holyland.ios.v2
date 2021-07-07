//
//  OneTitleAlertView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

class OneTitleAlertView: AlertView {
    
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
            $0.width.equalTo(250)
            $0.height.equalTo(150)
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(grayBar.snp.top)
            $0.leading.equalToSuperview().offset(Constants.Design.basicPadding)
            $0.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
        }
    }
}
