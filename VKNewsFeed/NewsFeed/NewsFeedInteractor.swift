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
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsfeed:
            service?.getFeed(completion: { [weak self] (revealPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealdedPostIds: revealPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
        case .revealPostId(postId: let postId):
            service?.revealPostIds(forPostIds: postId, completion: { [weak self] (revealPostIds, feed) in
                
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealdedPostIds: revealPostIds))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            
            service?.getNextBatch(completion: { (revealPostIds, feed) in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealdedPostIds: revealPostIds))
            })
        }
    }
}
