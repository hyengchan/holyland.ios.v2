//
//  Video.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation

struct Video: Codable {
    let url: String
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case url = "video_url"
        case title = "video_title"
        case description = "video_desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)

        do {
            // video_url type은 string
            url = try values.decode(String.self, forKey: .url)
        } catch {
            // live_url type은 int
            let urlPath = try values.decode(Int.self, forKey: .url)
            url = "\(urlPath)"
        }
    }
}

extension Video {
    init(url: String, title: String, description: String) {
        self.url = url
        self.title = title
        self.description = description
    }
    
    static func dummy() -> Self {
        Video(url: "https://vimeo.com/361109632", title: "타이틀", description: "메세지/n메세지테스트")
    }
}
