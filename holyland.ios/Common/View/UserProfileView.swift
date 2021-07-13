//
//  UserProfileView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import UIKit
import RxSwift
import RxGesture
import RxCocoa

class UserProfileView: UIView {
    
    let nameLabelFont: UIFont
    let nameLabelColor: UIColor
    let classNameLabelFont: UIFont
    let classNameLabelColor: UIColor
    let nameLabelTopOffset: CGFloat
    let classNameLabelTopOffset: CGFloat
    
    private var nameLabel: UILabel!
    private var classNameLabel: UILabel!
    private var photoImageView: UIImageView!
    private var emotionImageView: UIImageView!
    private let disposeBag = DisposeBag()

    let imageViewTapped = PublishSubject<Void>()
    
    init(frame: CGRect = .zero,
         backgroundColor: UIColor = Asset.Color.lemon.color,
         nameLabelFont: UIFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 16),
         nameLabelColor: UIColor = Asset.Color.gray10.color,
         classNameLabelFont: UIFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 12),
         classNameLabelColor: UIColor = Asset.Color.gray6.color,
         nameLabelTopOffset: CGFloat = 8,
         classNameLabelTopOffset: CGFloat = 4) {
        
        self.nameLabelFont = nameLabelFont
        self.nameLabelColor = nameLabelColor
        self.classNameLabelFont = classNameLabelFont
        self.classNameLabelColor = classNameLabelColor
        self.nameLabelTopOffset = nameLabelTopOffset
        self.classNameLabelTopOffset = classNameLabelTopOffset
        
        super.init(frame: frame)
        
        self.backgroundColor = backgroundColor
        
        setupSubViews()
    }
    
    override init(frame: CGRect) {
        nameLabelFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 16)
        nameLabelColor = Asset.Color.gray10.color
        classNameLabelFont = FontFamily.NanumSquareRoundOTF.bold.font(size: 12)
        classNameLabelColor = Asset.Color.gray6.color
        nameLabelTopOffset = 8
        classNameLabelTopOffset = 4
        
        super.init(frame: frame)
        
        self.backgroundColor = Asset.Color.lemon.color
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Logging - deinit : UserProfileView")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.makeRounded()
    }
    
    private func setupSubViews() {
        createViews()
        addSubViews()
        addConstraints()

        self.photoImageView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                print("tapped")
                owner.imageViewTapped.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func createViews() {
        nameLabel = {
            let lbl = UILabel()
            lbl.font = nameLabelFont
            lbl.textColor = nameLabelColor
            return lbl
        }()
        
        classNameLabel = {
            let lbl = UILabel()
            lbl.font = classNameLabelFont
            lbl.textColor = classNameLabelColor
            return lbl
        }()
        
        photoImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFit
            return img
        }()
        
        emotionImageView = {
            let img = UIImageView()
            return img
        }()
    }
    
    private func addSubViews() {
        addSubview(nameLabel)
        addSubview(classNameLabel)
        addSubview(photoImageView)
        addSubview(emotionImageView)
    }
    
    private func addConstraints() {
        photoImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-21)
        }
        
        emotionImageView.snp.makeConstraints {
            $0.width.height.equalTo(53)
            $0.bottom.equalTo(photoImageView)
            $0.centerX.equalTo(photoImageView.snp.trailing)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(photoImageView)
            $0.top.equalTo(photoImageView.snp.bottom).offset(nameLabelTopOffset)
        }
        
        classNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(classNameLabelTopOffset)
        }
    }

    func configure(userPhotoURLPath: String,
                   gender: Gender,
                   emotion: Int,
                   userName: String,
                   className: String) {
        photoImageView.kf.setImage(with: URL(string: userPhotoURLPath),
                                   placeholder: User.basicProfilePhoto(by: gender))
        emotionImageView.image = Emotion(rawValue: emotion)?.image
        nameLabel.text = userName
        classNameLabel.text = className
    }

//    func addTapGestureToPhotoImageView(_ recognizer: UITapGestureRecognizer) {
//        self.isUserInteractionEnabled = true
//        photoImageView.isUserInteractionEnabled = true
//        photoImageView.addGestureRecognizer(recognizer)
//    }
}
