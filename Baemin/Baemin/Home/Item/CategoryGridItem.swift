//
//  CategoryModel.swift
//  Baemin
//
//  Created by 박정환 on 11/13/25.
//

import UIKit

public struct CategoryGridItem {
    public let name: String
    public let iconName: String?
    
    public init(name: String, iconName: String?) {
        self.name = name
        self.iconName = iconName
    }
    
    public static let mockData: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
    
    // MARK: - Tab-specific Category Data
    
    public static let foodItems: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
    
    public static let pickupItems: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
    
    public static let shoppingItems: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
    
    public static let giftItems: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
    
    public static let benefitItems: [CategoryGridItem] = [
        CategoryGridItem(name: "한그릇", iconName: "cat_1"),
        CategoryGridItem(name: "치킨", iconName: "cat_2"),
        CategoryGridItem(name: "카페·디저트", iconName: "cat_3"),
        CategoryGridItem(name: "피자", iconName: "cat_4"),
        CategoryGridItem(name: "분식", iconName: "cat_5"),
        CategoryGridItem(name: "고기", iconName: "cat_6"),
        CategoryGridItem(name: "짬땅", iconName: "cat_7"),
        CategoryGridItem(name: "야식", iconName: "cat_8"),
        CategoryGridItem(name: "패스트푸드", iconName: "cat_9"),
        CategoryGridItem(name: "피엡", iconName: "cat_10")
    ]
}
