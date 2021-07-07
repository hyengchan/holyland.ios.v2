//
//  FullScreenToastView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

class FullScreenToastView: UIView {
    
    var checkImageView: UIImageView!
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var backgroundView: UIView!
    
    @objc var removeCompletion: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
      setupViews()
    }
    
    func setupViews() {
        createViews()
        addSubViews()
    }
    
    func createViews() {
        checkImageView = {
            let imageView = UIImageView()
            
            return imageView
        }()
        
        titleLabel = {
            let lbl = UILabel()
            lbl.font = FontFamily.SpoqaHanSans.bold.font(size: 15)
            lbl.textColor = Asset.Color.gray1.color
            lbl.textAlignment = .center
            
            return lbl
        }()
        
        messageLabel = {
            let lbl = UILabel()
            lbl.font = FontFamily.SpoqaHanSans.regular.font(size: 12)
            lbl.textColor = Asset.Color.gray1.color
            lbl.lineBreakMode = .byWordWrapping
            lbl.numberOfLines = 0
            lbl.textAlignment = .center
            
            return lbl
        }()
        
        backgroundView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = 0.7
            
            return view
        }()
    }
    
    func addSubViews() {
        addSubview(backgroundView)
        addSubview(checkImageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    func addViewConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - methods
    func setImage(image: UIImage?) {
        checkImageView.image = image
    }
    
    func setText(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    func setFont(title: UIFont?, message: UIFont?) {
        titleLabel.font = title
        messageLabel.font = message
    }
    
    func setTextColor(titleColor: UIColor, messageColor: UIColor) {
        titleLabel.textColor = titleColor
        messageLabel.textColor = messageColor
    }
    
    func remove(timeInterval: Double = 2) {
        _ = Timer.scheduledTimer(timeInterval: timeInterval,
                                 target: self,
                                 selector: #selector(handlingToRemoveView),
                                 userInfo: nil,
                                 repeats: false)
    }
    
    @objc private func handlingToRemoveView() {
        removeCompletion?()
    }
    
}
