//
//  HomeViewController.swift
//  Baemin
//
//  Created by 박정환 on 11/12/25.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - ScrollView & ContentView
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Sub Views
    private let topBarView = TopBarView()
    private let searchBarView = SearchBarView()
    private let homeADView = HomeADView()
    private let categoryTabView = CategoryTabBarView()
    private let categoryGridView = CategoryGridView()
    private let categoryMoreView = CategoryMoreButtonView()
    private let brandView = BrandCollectionView()
    private let bannerView = BannerView()
    private let rankingView = RankingCollectionView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        setUI()
        setHierarchy()
        setLayout()
        bindActions()
        loadMockData()
    }

    private func setUI() {
        view.backgroundColor = .bgWhite
    }

    // MARK: - Add to view
    private func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            topBarView,
            searchBarView,
            homeADView,
            categoryTabView,
            categoryGridView,
            categoryMoreView,
            brandView,
            bannerView,
            rankingView
        )
    }

    // MARK: - Layout
    private func setLayout() {

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        topBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }

        searchBarView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        homeADView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

        categoryTabView.snp.makeConstraints {
            $0.top.equalTo(homeADView.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        categoryGridView.snp.makeConstraints {
            $0.top.equalTo(categoryTabView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        categoryMoreView.snp.makeConstraints {
            $0.top.equalTo(categoryGridView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        brandView.snp.makeConstraints {
            $0.top.equalTo(categoryMoreView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        bannerView.snp.makeConstraints {
            $0.top.equalTo(brandView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        rankingView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(279)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    private func bindActions() {
        categoryTabView.onSelectIndex = { [weak self] index in
            self?.categoryGridView.scrollToPage(index)
        }

        categoryGridView.onPageChanged = { [weak self] index in
            self?.categoryTabView.updateSelectedIndex(index)
        }
    }

    private func loadMockData() {
        // 탭 아이템 설정
        categoryTabView.configure(items: CategoryTabItem.mockData)

        // 탭에 대응하는 CategoryGrid 페이지 생성
        let pages: [[CategoryGridItem]] = [
            CategoryGridItem.foodItems,
            CategoryGridItem.pickupItems,
            CategoryGridItem.shoppingItems,
            CategoryGridItem.giftItems,
            CategoryGridItem.benefitItems
        ]

        categoryGridView.configure(pages: pages)

        // 브랜드
        brandView.configure(with: BrandModel.mockData)

        // 배너
        bannerView.configure(with: BannerModel.mockData)
        rankingView.configure(with: RankingModel.mockData)
    }
}

#Preview() {
    HomeViewController()
}
