//
//  VideoCollectionViewCell.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/06.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var onOffBadge: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        onOffBadge.isHidden = true
        layer.cornerRadius = 15
    }

    func configure(with videoInformation: VideoInformation) {
        var title: String
        var image: UIImage?

        switch videoInformation.kind {
        case .vimeo(let type):
            title = type.description

            switch type {
            case .day:
                image = UIImage(asset: Asset.Assets.icChurchDay)
            case .night:
                image = UIImage(asset: Asset.Assets.icChurchNight)
            case .live:
                image = UIImage(asset: Asset.Assets.icLive)
            }

        case .youtube(let type):
            title = type.description

            switch type {
            case .firePillarBible:
                image = UIImage(asset: Asset.Assets.icBible)
            case .morningTreatBible:
                image = UIImage(asset: Asset.Assets.icAmen)
            case .earlyLoveBible:
                image = UIImage(asset: Asset.Assets.icFriday)
            }
        }

        titleLabel.text = title
        imageView.image = image
        onOffBadge.isHidden = !((videoInformation.viewable) ?? false)
    }
}
