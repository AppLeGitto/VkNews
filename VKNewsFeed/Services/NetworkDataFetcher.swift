//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 24.05.2022.
//

import Foundation

protocol DataFetcher {
    
    func getFeed(response: @escaping (FeedResponse?) -> ())
    func getUser(response: @escaping (UserResponse?) -> ())
}

struct NetworkDataFetcher: DataFetcher {
    
    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> ()) {
        
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> ()) {
        guard let userId = authService.userId else { return }
        
        let params = ["fields": "photo_100", "user_ids": userId]
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }

    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
