//
//  MainView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/06.
//

import UIKit
import SnapKit
import NSObject_Rx

class MainView: UIView {
    lazy var myPageButton = createMyPageButton()
    lazy var qrPageButton = createQRPageButton()
    lazy var bannerBarImageView = createBannerBarImageView()
    lazy var profileView = UserProfileView(nameLabelFont: FontFamily.NanumSquareRoundOTF.extraBold.font(size: 16))

    lazy var goldKeyContainerView = createGoldKeyContainer()
    lazy var goldKeyTitleLabel = createKeyTitleLabel()
    lazy var goldKeyMessageLabel = createGoldKeyMessageLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .white

        addSubview(bannerBarImageView)
        addSubview(profileView)
        addSubview(goldKeyContainerView)
        goldKeyContainerView.addSubview(goldKeyTitleLabel)
        goldKeyContainerView.addSubview(goldKeyMessageLabel)
        addSubview(myPageButton)
        addSubview(qrPageButton)

        addViewConstraints()
    }
}
