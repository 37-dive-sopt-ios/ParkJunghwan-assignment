//
//  PostResponseDTO.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

struct PostResponseDTO: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension PostResponseDTO {
    func toEntity() -> Post {
        Post(id: id, userId: userId, title: title, body: body)
    }
}
