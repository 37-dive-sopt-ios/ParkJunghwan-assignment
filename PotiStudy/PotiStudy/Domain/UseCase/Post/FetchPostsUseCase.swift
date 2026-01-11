//
//  FetchPostsUseCase.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

// MARK: - Interface
protocol FetchPostsUseCase {
    func execute() async throws -> [Post]
}

// MARK: - UseCase
final class DefaultFetchPostsUseCase: FetchPostsUseCase {
    private let repository: PostRepository

    init(repository: PostRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Post] {
        try await repository.fetchPosts()
    }
}
