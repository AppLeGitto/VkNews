//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 24.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsfeed:
            fetcher.getFeed { [weak self] (feedResponse) in
                
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .getUser:
            fetcher.getUser { (userResponse) in
                self.presenter?.presentData(response: .presentUserInfo(user: userResponse))
            }
        case .revealPostId(postId: let postId):
            
            revealedPostIds.append(postId)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealdedPostIds: revealedPostIds))
    }
    
}
