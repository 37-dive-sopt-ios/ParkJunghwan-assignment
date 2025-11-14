//
//  RankingCell.swift
//  Baemin
//
//  Created by 박정환 on 11/14/25.
//

import UIKit
import SnapKit
import Then

final class RankingCell: UICollectionViewCell {
    
    static let identifier = "RankingCell"
    
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .gray200
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .gray600
    }

    private let ratingLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .gray600
    }
    
    private let menuLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .baeminBlack
        $0.numberOfLines = 1
    }

    private let saleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = UIColor.systemRed
    }

    private let priceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = .baeminBlack
    }
    
    private let beforePriceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .gray600
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: RankingModel) {
        thumbnailImageView.image = model.image
        titleLabel.text = model.title
        ratingLabel.text = "⭐️ \(model.rating) (\(model.reviewCount))"
        menuLabel.text = model.menu
        saleLabel.text = "\(model.salePercent)%"
        priceLabel.text = model.price
        beforePriceLabel.text = model.beforePrice
    }
}

private extension RankingCell {
    func setupHierarchy() {
        contentView.addSubviews(
            thumbnailImageView, titleLabel, ratingLabel,
            menuLabel, saleLabel, priceLabel, beforePriceLabel
        )
    }
    
    func setupLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(145)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(9)
            $0.leading.equalToSuperview()
        }

        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }

        menuLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }

        saleLabel.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(saleLabel.snp.centerY)
            $0.leading.equalTo(saleLabel.snp.trailing).offset(6)
        }

        beforePriceLabel.snp.makeConstraints {
            $0.top.equalTo(saleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
    }
}
