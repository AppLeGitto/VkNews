//
//   UserResponse.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 07.06.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
