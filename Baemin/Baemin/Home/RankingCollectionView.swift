//
//  RankingCollectionView.swift
//  Baemin
//
//  Created by 박정환 on 11/14/25.
//

import UIKit
import SnapKit
import Then

final class RankingCollectionView: UIView {

    private var items: [RankingModel] = []

    private lazy var titleLabel = UILabel().then {
        $0.text = "우리 동네 한그릇 인기 랭킹"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        $0.textColor = .baeminBlack
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setTitle("전체보기 >", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
    }

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: 145, height: 243) // 카드 크기
        }
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(RankingCell.self, forCellWithReuseIdentifier: RankingCell.identifier)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with items: [RankingModel]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension RankingCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RankingCell.identifier,
            for: indexPath
        ) as! RankingCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
}

private extension RankingCollectionView {
    func setupHierarchy() {
        addSubviews(titleLabel, moreButton, collectionView)
    }

    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
