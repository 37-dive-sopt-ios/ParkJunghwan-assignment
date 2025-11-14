//
//  RankingModel.swift
//  Baemin
//
//  Created by 박정환 on 11/14/25.
//

import UIKit

struct RankingModel {
    let image: UIImage
    let title: String
    let rating: Double
    let reviewCount: Int
    let menu: String
    let salePercent: Int
    let price: String
    let beforePrice: String
    
    static let mockData: [RankingModel] = [
        RankingModel(
            image: UIImage(named: "rank1") ?? UIImage(),
            title: "백억보쌈제육...",
            rating: 5.0,
            reviewCount: 1973,
            menu: "[든든한 한끼] 보쌈 막국수",
            salePercent: 25,
            price: "12,000원",
            beforePrice: "16,000원"
        ),
        RankingModel(
            image: UIImage(named: "rank2") ?? UIImage(),
            title: "백억보쌈제육...",
            rating: 5.0,
            reviewCount: 1973,
            menu: "(1인) 피자 + 사이드 Set",
            salePercent: 20,
            price: "12,000원",
            beforePrice: "16,000원"
        ),
        RankingModel(
            image: UIImage(named: "rank2") ?? UIImage(),
            title: "백억보쌈제육...",
            rating: 5.0,
            reviewCount: 1973,
            menu: "(1인) 피자 + 사이드 Set",
            salePercent: 20,
            price: "12,000원",
            beforePrice: "16,000원"
        ),
        RankingModel(
            image: UIImage(named: "rank2") ?? UIImage(),
            title: "백억보쌈제육...",
            rating: 5.0,
            reviewCount: 1973,
            menu: "(1인) 피자 + 사이드 Set",
            salePercent: 20,
            price: "12,000원",
            beforePrice: "16,000원"
        )
    ]
}
