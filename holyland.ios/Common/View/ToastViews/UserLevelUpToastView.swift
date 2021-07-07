//
//  UserLevelUpToastView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit
import Kingfisher

class UserLevelUpToastView: FullScreenToastView {
    
    private var animationImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showWithLevel(previous: Int, current: Int) {
        playAnimation()
        setText(previousLevel: previous, currentLevel: current)
    }
    
    private func setupSubViews() {
        self.insertSubview(animationImageView, aboveSubview: backgroundView)
        
        setFont()
        setTextColor()
        setImage()
    }
    
    private func setupConstraints() {
        checkImageView.snp.makeConstraints {
            $0.width.equalTo(226)
            $0.height.equalTo(86)
            $0.top.equalToSuperview().offset(frame.height * 0.32)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(checkImageView.snp.bottom).offset(12)
        }
        
        messageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        animationImageView.snp.makeConstraints {
            $0.edges.equalTo(backgroundView)
        }
    }
    
    private func setFont() {
        let titleFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 36)
        let messageFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 14)
        
        setFont(title: titleFont, message: messageFont)
    }
    
    private func setTextColor() {
        setTextColor(titleColor: Asset.Color.main.color, messageColor: Asset.Color.gray1.color)
    }
    
    private func setImage() {
        setImage(image: #imageLiteral(resourceName: "imgLevelUp"))
    }
    
    private func setText(previousLevel: Int, currentLevel: Int) {
        let goldkeyAmountPerLevel = Constants.GoldKey.amountPerLevel
        let title = "Lv.\(currentLevel)"
        let message = "축하해요! 금키 \(goldkeyAmountPerLevel)개를 다 모아서 \n\(previousLevel)레벨에서 \(currentLevel)레벨로 레벨업 했어요!"
        super.setText(title: title, message: message)
    }

    private func playAnimation() {
        let path = Bundle.main.path(forResource: "confettie_x3_1080_24f", ofType: "gif")
        let url = URL(fileURLWithPath: path!)
        let provider = LocalFileImageDataProvider(fileURL: url)
        
        animationImageView.kf.setImage(with: provider, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageResult):
                // play only once
                let image = imageResult.image
                self.animationImageView.animationImages = image.images
                self.animationImageView.animationDuration = image.duration
                self.animationImageView.animationRepeatCount = 0
                self.animationImageView.image = image.images?.last
                self.animationImageView.startAnimating()
                
            case .failure(let error):
                print(error)
            }
        })
    }
}
