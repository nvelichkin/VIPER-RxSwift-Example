//
//  PostsManagerPath.swift
//  Viper-RxSwift-Example
//
//  Created by Nikita Velichkin on 19/01/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import Moya
import RxSwift

enum PostsManagerPath {
    case getPosts
    case getPost(postId: Int)
    case addPost(post: Post)
}

extension PostsManagerPath: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/posts")!
    }
    
    var path: String {
        switch self {
        case .getPosts, .addPost:
            return ""
        case let .getPost(postId):
            return String(postId)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts, .getPost:
            return .get
        case .addPost:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPosts, .getPost:
            return .requestPlain
        case let .addPost(post):
            return .requestJSONEncodable(post)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=UTF-8"]
    }
    
    
}
