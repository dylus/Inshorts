//
//  News+Helpers.swift
//  InshortsTests
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation
@testable import Inshorts

extension News {
    static var news: News {
        News(category: "all", articles: [Article.article, Article.article], success: true)
    }
}

extension Article {
    static var article: Article {
        Article(author: "Pragya Swastik",
                content: "Astronomers have unveiled the first image of the supermassive black hole at the centre of the Milky Way galaxy. \"The new view captures light bent by the powerful gravity of the black hole, which is four million times more massive than our Sun,\" astronomers said. The image was produced by a global research team called the Event Horizon Telescope Collaboration.",
                date: "12 May 2022,Thursday",
                imageURL: "https://static.inshorts.com/inshorts/images/v1/variants/jpg/m/2022/05_may/12_thu/img_1652364680010_849.jpg?",
                readMoreURL: "https://eventhorizontelescope.org/blog/astronomers-reveal-first-image-black-hole-heart-our-galaxy?utm_campaign=fullarticle&utm_medium=referral&utm_source=inshorts ",
                time: "07:50 pm",
                title: "First pic of supermassive black hole at the centre of Milky Way released",
                url: "https://www.inshorts.com/en/news/first-pic-of-supermassive-black-hole-at-the-centre-of-milky-way-released-1652365232463")
    }
}
