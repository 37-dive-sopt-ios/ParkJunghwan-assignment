//
//  PostRepository.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

// MARK: -  Interface
protocol PostInterface {
    func fetchPosts() async throws -> [Post]
}
