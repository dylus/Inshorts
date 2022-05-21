//
//  HomeListViewModel.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation
import Combine


enum NewsSection: String, CaseIterable {
    case all
    case national
    case business
    case sports
    case world
    case politics
    case technology
    case startup
    case entertainment
    case miscellaneous
    case hatke
    case science
    case automobile
}

enum HomeListViewModelState {
    case pending
    case finished(News?)
    case failure(Error)
}

protocol HomeListViewModelProtocol {
    var state: HomeListViewModelState { get }
    func fetchNews(section: NewsSection)
}

final class HomeListViewModel: HomeListViewModelProtocol, ObservableObject {
    private let newsService: NewsServiceProtocol
    private var store = Set<AnyCancellable>()

    @Published private(set) var state: HomeListViewModelState = .pending

    private var news: News?

    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }

    func fetchNews(section: NewsSection) {
        guard let endpoint = Endpoint(rawValue: section.rawValue) else {
            // TODO: Make sure we have better error here
            state = .failure(APIError.unknown)
            debugPrint("Error - can't find Endpoint for section \(section.rawValue)")
            return
        }
        newsService
            .requestNews(endpoint: endpoint)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finished(self?.news)
                case .failure( let error ):
                    self?.state = .failure(error)
                }
            } receiveValue: { news in
                self.news = news
            }
            .store(in: &store)
    }
}
