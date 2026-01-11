//
//  PostAPI.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

import Foundation
import Moya
import Alamofire

enum PostAPI {
    case posts
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .posts:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["accept": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
