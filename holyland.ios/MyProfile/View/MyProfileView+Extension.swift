//
//  MyProfileView+Extension.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/15.
//

import UIKit

extension MyProfileView {
    func createBackButton() -> UIButton {
        let button = UIButton()
        button.setImage(Asset.Assets.btnBack.image, for: .normal)
        return button
    }

    func createOKButton() -> UIButton {
        let button = UIButton()
        button.setImage(Asset.Assets.btnSaveOn.image, for: .normal)
        return button
    }

    func createTopicLabel() -> UILabel {
        let label = UILabel()
        label.text = "프로필 바꾸기"
        label.textColor = Asset.Color.gray9.color
        label.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 19)
        label.textAlignment = .center
        return label
    }

    func createChangePhotoButton() -> UIButton {
        let button = UIButton()
        button.setTitle("프로필 사진 설정", for: .normal)
        button.setTitleColor(Asset.Color.gray7.color, for: .normal)
        button.titleLabel?.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 12)
        return button
    }

    func createPhotoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    func addViewConstraints() {
        let navigationHeight: CGFloat = 64
        let profileImageViewHeight: CGFloat = 100
        let collectionViewheight = self.frame.height * 0.46
        let profileImageViewCenterY = (self.frame.height - navigationHeight - collectionViewheight) / 2

        backButton.snp.makeConstraints {
            $0.size.equalTo(navigationHeight)
            $0.leading.equalToSuperview().offset(6)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }

        okayButton.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(navigationHeight)
            $0.trailing.equalToSuperview().inset(6)
            $0.top.equalTo(backButton)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing)
            $0.trailing.equalTo(okayButton.snp.leading)
            $0.top.equalTo(backButton.snp.top)
            $0.height.equalTo(navigationHeight)
        }

        emotionCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(collectionViewheight)
        }

        photoImageView.snp.makeConstraints {
            $0.size.equalTo(profileImageViewHeight)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(profileImageViewCenterY)
        }

        emotionImageView.snp.makeConstraints {
            $0.width.height.equalTo(53)
            $0.centerX.equalTo(photoImageView.snp.trailing)
            $0.bottom.equalTo(photoImageView.snp.bottom)
        }

        changePhotoButton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(16)
            $0.leading.trailing.centerX.equalToSuperview()
        }
    }
}
