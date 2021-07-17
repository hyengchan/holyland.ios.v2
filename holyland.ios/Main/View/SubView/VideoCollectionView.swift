//
//  VideoCollectionView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import UIKit
import RxSwift
import RxCocoa

class VideoCollectionView: UIView {

    let itemsPerRow: CGFloat = 3
    let sectionPadding: CGFloat = 8
    let sectionInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

    var disposeBag = DisposeBag()

    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        createViews()
        addSubViews()
        addViewConstraints()
        bindViews()
    }

    // MARK: - Rx
    func bindViews() {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    // MARK: - UI components
    func createViews() {
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            let cell = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
            collectionView.register(cell, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
            return collectionView
        }()
    }

    func addSubViews() {
        addSubview(collectionView)
    }

    func addViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(sectionPadding)
            $0.trailing.equalToSuperview().inset(sectionPadding)
            $0.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VideoCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = (sectionInsets.left * (itemsPerRow + 1) + sectionPadding) * (itemsPerRow - 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
