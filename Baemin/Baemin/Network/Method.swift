//
//  Method.swift
//  sopt-37th-03Seminar
//
//  Created by 박정환 on 11/21/25.
//

import Foundation

/// HTTP 메서드 (Moya의 Method와 동일!)
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
