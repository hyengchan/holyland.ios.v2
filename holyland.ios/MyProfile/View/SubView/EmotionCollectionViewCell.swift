//
//  EmotionCollectionViewCell.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/15.
//

import UIKit

class EmotionCollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView!
    var nameLabel: UILabel!

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.backgroundColor = Asset.Color.gray1.color
                self.layer.borderWidth = 2
            } else {
                self.contentView.backgroundColor = .clear
                self.layer.borderWidth = 0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        createViews()
        addSubViews()
        addConstraints()

        self.makeRounded(radius: 15)
        self.layer.borderColor = Asset.Color.main.color.cgColor
    }

    func createViews() {
        imageView = UIImageView()
        nameLabel = {
            let label = UILabel()
            label.font = FontFamily.NanumSquareRoundOTF.bold.font(size: 12)
            label.textColor = Asset.Color.gray10.color
            return label
        }()
    }

    func addSubViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }

    func addConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalTo(imageView.snp.height).multipliedBy(1)
        }

        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(4)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
    }

    func configure(image: UIImage?, title: String) {
        imageView.image = image
        nameLabel.text = title
    }

}
