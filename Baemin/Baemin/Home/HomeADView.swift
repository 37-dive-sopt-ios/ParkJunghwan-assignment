//
//  homeADView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class HomeADView: UIView {

    private let adImageView = UIImageView().then {
        $0.image = UIImage(named: "bmartIcon")
        $0.contentMode = .scaleAspectFit
    }

    private let adLabel = UILabel().then {
        $0.text = "전상품 쿠폰팩 + 60% 특가 >"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .baeminBlack
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }

    private func setHierarchy() {
        addSubviews(adImageView, adLabel)
    }

    private func setLayout() {
        adImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        adLabel.snp.makeConstraints {
            $0.top.equalTo(adImageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
