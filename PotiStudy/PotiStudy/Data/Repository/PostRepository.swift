//
//  PostRepositoryImpl.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

import Foundation
import Moya

// MARK: - Repository
final class PostRepository: PostInterface {
    private let service: PostService

    init(service: PostService) {
        self.service = service
    }

    func fetchPosts() async throws -> [Post] {
        let response = try await service.request(.posts)
        let dtos = try JSONDecoder().decode([PostResponseDTO].self, from: response.data)
        return dtos.map { $0.toEntity() }
    }
}
