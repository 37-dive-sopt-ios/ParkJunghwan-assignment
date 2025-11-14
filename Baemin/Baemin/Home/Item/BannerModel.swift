//
//  BannerModel.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit

struct BannerModel {
    let image: UIImage
    let linkURL: String?  // 배너 클릭 시 이동 (확장 가능)
}

extension BannerModel {
    static let mockData: [BannerModel] = [
        BannerModel(image: UIImage(named: "banner1") ?? UIImage(), linkURL: nil),
        BannerModel(image: UIImage(named: "banner2") ?? UIImage(), linkURL: nil),
        BannerModel(image: UIImage(named: "banner3") ?? UIImage(), linkURL: nil),
    ]
}
