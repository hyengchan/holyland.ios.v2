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

    func createProgressBar() -> UIProgressView {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = Asset.Color.goldkeyYellow.color
        progressBar.trackTintColor = Asset.Color.gray3.color
        return progressBar
    }

    func createGoldKeyCountingLabel() -> UILabel {
        let label = UILabel()
        label.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 10)
        label.textColor = Asset.Color.gray5.color
        label.textAlignment = .right
        return label
    }

   func createGrayLine() -> UIView {
        let view = UIView()
    view.backgroundColor = Asset.Color.gray4.color
        return view
    }

    func createVideoCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        let cell = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        return collectionView
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

        let bannerBarHeight = self.frame.width * 0.25
        bannerBarImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bannerBarHeight)
        }

        let videoCollectionViewHeight = self.frame.height * 0.37
        videoCollectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(videoCollectionViewHeight)
        }

        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            profileViewConstraint = $0.bottom.equalTo(goldKeyContainerView.snp.top).offset(-4).constraint
            $0.top.equalTo(bannerBarImageView.snp.bottom)
        }

        goldKeyContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.Design.basicPadding)
            $0.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
            $0.bottom.equalTo(videoCollectionView.snp.top).offset(-12)
            myGoldKeyInfoViewHeightConstraint = $0.height.equalTo(110).constraint
        }

        goldKeyTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(goldKeyMessageLabel.snp.top).offset(-4)
            $0.leading.equalToSuperview()
        }

        goldKeyMessageLabel.snp.makeConstraints {
            $0.bottom.equalTo(videoCollectionView.snp.top).offset(-12)
            $0.leading.equalToSuperview()
        }

        grayLineView.snp.makeConstraints {
            $0.bottom.equalTo(videoCollectionView.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        goldKeyImgView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview()
        }

        goldKeyProgressBar.snp.makeConstraints {
            $0.leading.equalTo(goldKeyImgView.snp.trailing).offset(-8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.centerY.equalTo(goldKeyImgView)
        }

        goldKeyCountingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }

        // remake constraints
        goldKeyContainerView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(Constants.Design.basicPadding)
            $0.trailing.equalToSuperview().inset(Constants.Design.basicPadding)
            $0.bottom.equalTo(grayLineView.snp.top).offset(-4)
            myGoldKeyInfoViewHeightConstraint = $0.height.equalTo(110).constraint
        }

        goldKeyMessageLabel.snp.remakeConstraints {
            $0.bottom.equalTo(goldKeyImgView.snp.top).offset(-8)
            $0.leading.equalToSuperview()
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
            AppbarNetworkService.dayAppbarImage()
                .asObservable()
                .catchAndReturn(nil)
                .subscribe(onNext: { [weak self] urlString in
                    guard let self = self else { return }
                    let placeholderImage = UIImage(named: "img_appbar_day")
                    setImage(urlPath: urlString, placeholderImage: placeholderImage, target: self.bannerBarImageView)
                })
                .disposed(by: rx.disposeBag)
        } else {
            AppbarNetworkService.nightAppbarImage()
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
