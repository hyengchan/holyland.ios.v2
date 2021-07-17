//
//  MyProfileView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/15.
//

import UIKit

class MyProfileView: UIView {

    lazy var backButton = createBackButton()
    lazy var okayButton = createOKButton()
    lazy var titleLabel = createTopicLabel()
    lazy var changePhotoButton = createChangePhotoButton()
    lazy var photoImageView = createPhotoImageView()
    lazy var emotionImageView = UIImageView()
    lazy var emotionCollectionView = EmotionCollectionView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .white
        self.isUserInteractionEnabled = true

        addSubview(backButton)
        addSubview(okayButton)
        addSubview(titleLabel)
        addSubview(changePhotoButton)
        addSubview(photoImageView)
        addSubview(emotionImageView)
        addSubview(emotionCollectionView)

        addViewConstraints()
    }
}
