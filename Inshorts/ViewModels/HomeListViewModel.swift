//
//  HomeListViewModel.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation
import Combine


enum NewsSection: String, CaseIterable, Identifiable, Equatable {
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

    var id: UUID {
        UUID()
    }
}

enum HomeListViewModelState {
    case pending
    case finished([Article])
    case failure(Error)
}

protocol HomeListViewModelProtocol {
    var state: HomeListViewModelState { get }
    func fetchNews(section: NewsSection)
}

final class HomeListViewModel: ObservableObject, HomeListViewModelProtocol {
    private let newsService: NewsServiceProtocol
    private var store = Set<AnyCancellable>()

    @Published private(set) var state: HomeListViewModelState = .pending

    private var articles = [Article]()

    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }

    func fetchNews(section: NewsSection) {
        state = .pending
        guard let endpoint = Endpoint(rawValue: section.rawValue) else {
            state = .failure(APIError.unknown)
            debugPrint("Error - can't find Endpoint for section \(section.rawValue)")
            return
        }
        newsService
            .requestNews(endpoint: endpoint)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    self.state = .finished(self.articles)
                case .failure( let error ):
                    self?.state = .failure(error)
                }
            } receiveValue: { [weak self] news in
                guard let articles = news.articles else { return }
                self?.articles = articles
            }
            .store(in: &store)
    }
}
