//
//  AlertView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit
import SnapKit

protocol SettingAlertViewComponents: NSObject {
    var title: String { get set }
    var message: String? { get set }
    var okay: String { get set }
    var cancel: String? { get set }
    func setBody(title: String, message: String?, okay: String, cancel: String?)
    func setDefaultBody(type: AlertType)
    func addButtonTarget()
    func setupConstraints()
}

extension SettingAlertViewComponents {
    func setBody(title: String, message: String?, okay: String, cancel: String? = nil) {
        self.title = title
        self.message = message
        self.okay = okay
        self.cancel = cancel
    }
    
    public func setDefaultBody(type: AlertType) {
        let myBody = type.getBody()
        setBody(title: myBody.title, message: myBody.message, okay: myBody.okay, cancel: myBody.cancel)
    }
}

class AlertView: UIView {
    var okayActionCompletion: (() -> Void)?
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        self.addSubview(view)
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Asset.Color.gray1.color
        contentView.makeRounded(radius: 20)
        self.addSubview(contentView)
        
        return contentView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = Asset.Color.gray9.color
        lbl.font = FontFamily.SpoqaHanSans.bold.font(size: 14)
        contentView.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = Asset.Color.gray7.color
        lbl.font = FontFamily.SpoqaHanSans.bold.font(size: 13)
        contentView.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var okayButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(Asset.Color.main.color, for: .normal)
        btn.titleLabel?.font = FontFamily.SpoqaHanSans.bold.font(size: 15)
        contentView.addSubview(btn)
        
        return btn
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(Asset.Color.gray6.color, for: .normal)
        btn.titleLabel?.font = FontFamily.SpoqaHanSans.bold.font(size: 15)
        contentView.addSubview(btn)
        
        return btn
    }()
    
    lazy var grayBar: UIView = {
        let grayBarView = UIView()
        grayBarView.backgroundColor = Asset.Color.gray4.color
        contentView.addSubview(grayBarView)
        
        return grayBarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        addButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView() {
        self.removeFromSuperview()
    }
    
    @objc func doOkayAction() {
        self.removeFromSuperview()
        okayActionCompletion?()
    }
}

extension AlertView: SettingAlertViewComponents {
    var title: String {
        get {
            return self.titleLabel.text ?? ""
        }
        set {
            self.titleLabel.text = newValue
        }
    }
        
    var okay: String {
        get {
            return self.okayButton.currentTitle ?? ""
        }
        set {
            self.okayButton.setTitle(newValue, for: .normal)
        }
    }
    
    @objc var message: String? {
        get { return nil }
        set { }
    }
    
    @objc var cancel: String? {
        get { return nil }
        set { }
    }
    
    @objc func addButtonTarget() {
        okayButton.addTarget(self, action: #selector(doOkayAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
