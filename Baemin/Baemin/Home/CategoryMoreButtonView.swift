//
//  categoryMoreView.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit
import SnapKit
import Then

final class CategoryMoreButtonView: UIView {

    // MARK: - UI
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = .baeminBlack
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .baeminBlack
        $0.contentMode = .scaleAspectFit
    }
    

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        addTapEffect()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first?.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
    }
}

// MARK: - UI Setup
private extension CategoryMoreButtonView {

    func setUI() {
        backgroundColor = .white
        let attributed = NSMutableAttributedString()
        attributed.append(NSAttributedString(
            string: "음식배달",
            attributes: [
                .font: UIFont(name: "Pretendard-Bold", size: 14)!,
                .foregroundColor: UIColor.baeminBlack
            ]
        ))
        attributed.append(NSAttributedString(
            string: "에서 더보기",
            attributes: [
                .font: UIFont(name: "Pretendard-Regular", size: 14)!,
                .foregroundColor: UIColor.baeminBlack
            ]
        ))
        titleLabel.attributedText = attributed
        let topBorder = CALayer()
        topBorder.backgroundColor = UIColor(named: "bgWhite")?.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        layer.addSublayer(topBorder)
    }

    func setHierarchy() {
        addSubviews(titleLabel, arrowImageView)
    }

    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(12)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(34)
        }
    }

    func addTapEffect() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc func tapAction() {
        // TODO: Delegate or Callback 연결 가능
        print("더보기 버튼 tapped!")
    }
}
