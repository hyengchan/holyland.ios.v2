//
//  ToastView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

class ToastView: UIView {
    
    enum ToastType {
        case basic
        case scanningQR
    }
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Asset.Color.gray1.color
        lbl.textAlignment = .center
        addSubview(lbl)
        
        return lbl
    }()
    
    init(frame: CGRect, message: String, type: ToastType) {
        super.init(frame: frame)
        
        switch type {
        case .basic: setupBasicToast(with: message)
        case .scanningQR: scanningQRToast(with: message)
        }
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        title.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
    }
    
    private func setupBasicToast(with message: String) {
        self.backgroundColor = Asset.Color.gray6.color
        self.makeRounded(radius: 15)
        self.title.text = message
        self.title.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 15)
    }
    
    private func scanningQRToast(with message: String) {
        self.backgroundColor = Asset.Color.gray9.color
        self.makeRounded(radius: 18)
        self.title.text = message
        self.title.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 12)
    }
}
