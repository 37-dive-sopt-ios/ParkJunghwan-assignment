//
//  Post.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

// MARK: - Entity
struct Post: Identifiable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
