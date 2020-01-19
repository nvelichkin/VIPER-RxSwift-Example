//
//  Post.swift
//  Viper-RxSwift-Example
//
//  Created by Nikita Velichkin on 19/01/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import Foundation
import RxDataSources

struct Post: Codable {
    var id: Int
    var title: String
    var body: String
    var userId: Int
}

extension Post: IdentifiableType {
    typealias Identity = Int
    var identity: Int { return id }
}

extension Post: Equatable {
    
}
