//
//  ContentView.swift
//  InshortsAPI
//
//  Created by Michal Dylka on 20/05/2022.
//

import SwiftUI

struct HomeListView: View {
    @StateObject private var viewModel = HomeListViewModel(newsService: NewsService())
    @State private var selectedNewsSectionIndex: NewsSection = .all

    var body: some View {
        Group {
            NavigationView {
                VStack {
                    ScrollView(.horizontal) {
                        Picker("News Section Picker", selection: $selectedNewsSectionIndex) {
                            ForEach(NewsSection.allCases) {
                                Text($0.rawValue.capitalized).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .onChange(of: selectedNewsSectionIndex) {
                            viewModel.fetchNews(section: $0)
                        }
                    }

                    Spacer()

                    switch viewModel.state {
                    case .pending:
                        ProgressView()
                        Spacer()
                    case .finished(let articles):
                        List(articles) { item in
                            NavigationLink(destination: ArticleDetailsView(article: item)) {
                                ArticleListItemView(article: item)
                            }
                        }
                    case .failure(let error):
                        LoadingErrorView(error: error).onTapGesture {
                            viewModel.fetchNews(section: selectedNewsSectionIndex)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }.onAppear() {
            viewModel.fetchNews(section: selectedNewsSectionIndex)
        }.refreshable {
            viewModel.fetchNews(section: selectedNewsSectionIndex)
        }
    }
}
