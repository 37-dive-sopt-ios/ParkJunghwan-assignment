//
//  BrandModel.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit

struct BrandModel {
    let image: UIImage
    let title: String
    
    static let mockData: [BrandModel] = [
        .init(image: UIImage(named: "brand_bmart") ?? UIImage(), title: "B마트"),
        .init(image: UIImage(named: "brand_cu") ?? UIImage(), title: "CU"),
        .init(image: UIImage(named: "brand_emartsp") ?? UIImage(), title: "이마트슈퍼"),
        .init(image: UIImage(named: "brand_homeplus") ?? UIImage(), title: "홈플러스"),
        .init(image: UIImage(named: "brand_gs25") ?? UIImage(), title: "GS25"),
        .init(image: UIImage(named: "brand_emart") ?? UIImage(), title: "이마트"),
    ]
}
