//
//  DataNews.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 08.02.2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

struct News : Codable {
    let news : [New]
}

struct New: Codable {
    let imageHeader: String
    let headerLabel: String
    let newsTextLabel: String
    let imageNews: [String]
    var isLiked: Bool
    var countLike: Int
    
    // Custom init to set isLiked bool to false
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageHeader = try container.decode(String.self, forKey: .imageHeader)
        headerLabel = try container.decode(String.self, forKey: .headerLabel)
        newsTextLabel = try container.decode(String.self, forKey: .newsTextLabel)
        imageNews = try container.decode([String].self, forKey: .imageNews)
        isLiked = false
        countLike = try container.decode(Int.self, forKey: .countLike)
    }
    
    // Decode JSON
    static func newsFromBundle() -> [New] {
        var news: [New] = []
        let url = Bundle.main.url(forResource: "news", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(News.self, from: data)
            news = json.news
        }
        catch {
            print("Error occured during Parsing", error)
        }
        return news
    }
}
