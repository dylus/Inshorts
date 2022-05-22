//
//  ArticleDetailsView.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import SwiftUI
import URLImage

struct ArticleDetailsView: View {
    let article: Article

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let imageURL = article.imageURL, let url = URL(string: imageURL) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                Text(article.content ?? "").font(.system(size: 20, weight: .medium)).padding()
            }
        }
    }
}
