//
//  MainViewController+Helper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import UIKit

// MARK: - Create UI components using code
extension MainView {
    func createMyPageButton() -> UIButton {
        let button = UIButton()
        button.setImage(Asset.Assets.btnMypage.image, for: .normal)
        return button
    }

    func createQRPageButton() -> UIButton {
        let button = UIButton()
        button.setImage(Asset.Assets.btnQr.image, for: .normal)
        return button
    }

    func createBannerBarImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }

    func createGoldKeyContainer() -> UIView {
        let view = UIView()
        return view
    }

    func createKeyTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 16)
        label.textColor = Asset.Color.gray9.color
        return label
    }

    func createGoldKeyMessageLabel() -> UILabel {
        let label = UILabel()
        label.font =  FontFamily.NanumSquareRoundOTF.extraBold.font(size: 14)
        label.textColor = Asset.Color.gray6.color
        return label
    }

    func addViewConstraints() {
        myPageButton.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.leading.equalToSuperview().offset(6)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }

        qrPageButton.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(64)
            $0.trailing.equalToSuperview().inset(6)
            $0.top.equalTo(myPageButton)
        }

        let bannerBarHeight = self.frame.height * 0.25
        bannerBarImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bannerBarHeight)
        }

//        let videoCollectionViewHeight = view.frame.height * 0.37
//        videoCollectionView.snp.makeConstraints {
//            $0.bottom.leading.trailing.equalToSuperview()
//            $0.height.equalTo(videoCollectionViewHeight)
//        }

        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(bannerBarImageView.snp.bottom)
            $0.height.equalTo(100)
        }

        goldKeyContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(profileView.snp.bottom)
            $0.height.equalTo(100)
        }

        self.layoutIfNeeded()
    }
}

// MARK: - Extension
extension MainView {
    func setAppbarImage(with date: Date) {
        func setImage(urlPath: String?, placeholderImage: UIImage?, target: UIImageView) {
            guard let replacedUrlPath = urlPath?.replacingOccurrences(of: "\"", with: "") else {
                target.image = placeholderImage
                return
            }
            target.kf.setImage(with: URL(string: replacedUrlPath),
                               placeholder: placeholderImage)
        }

        if Constants.Time.appbarDay ~= date.get(.hour) {
            NetworkClient.dayAppbarImage()
                .asObservable()
                .catchAndReturn(nil)
                .subscribe(onNext: { [weak self] urlString in
                    guard let self = self else { return }
                    let placeholderImage = UIImage(named: "img_appbar_day")
                    setImage(urlPath: urlString, placeholderImage: placeholderImage, target: self.bannerBarImageView)
                })
                .disposed(by: rx.disposeBag)
        } else {
            NetworkClient.nightAppbarImage()
                .asObservable()
                .catchAndReturn(nil)
                .subscribe(onNext: { [weak self] urlString in
                    guard let self = self else { return }
                    let placeholderImage = UIImage(named: "img_appbar_night")
                    setImage(urlPath: urlString, placeholderImage: placeholderImage, target: self.bannerBarImageView)
                })
                .disposed(by: rx.disposeBag)
        }
    }
}
