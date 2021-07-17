//
//  EmotionCollectionView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import NSObject_Rx

class EmotionCollectionView: UIView {

    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)

    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }

    func commomInit() {
        createViews()
        addSubviews()
        addViewConstraints()
        bindViews()
    }

    func bindViews() {
        collectionView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
    }

    func createViews() {
        collectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.identifier)
            collectionView.backgroundColor = Asset.Color.gray2.color
            collectionView.showsHorizontalScrollIndicator = false

            return collectionView
        }()
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func addViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension EmotionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
