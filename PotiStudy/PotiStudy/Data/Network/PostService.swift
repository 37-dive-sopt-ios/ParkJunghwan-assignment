//
//  PostService.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

import Foundation
import Moya

final class PostService {
    let provider = MoyaProvider<PostAPI>()
    
    func request(_ target: PostAPI) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
