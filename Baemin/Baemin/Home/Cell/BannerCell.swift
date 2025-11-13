//
//  BannerCell.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import Foundation
import UIKit
import SnapKit
import Then

final class BannerCell: UICollectionViewCell {

    static let identifier = "BannerCell"

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupHierarchy() {
        contentView.addSubview(imageView)
    }

    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(with model: BannerModel) {
        imageView.image = model.image
    }
}
