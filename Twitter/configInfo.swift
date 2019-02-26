//
//  configInfo.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/17/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

enum tweetKeys {
    static let retweet = "retweeted_status"
    static let user = "user"
    static let id = "id"
    static let text = "full_text"
    static let favCount = "favorite_count"
    static let favStatus = "favorited"
    static let retCount = "retweet_count"
    static let retStatus = "retweeted"
    static let trunc = "truncated"
    static let created = "created_at"
    static let extend = "extended_entities"
    static let media = "media"
    static let mediaURL = "media_url_https"
    static let type = "type"
}

enum userKeys {
    static let name = "name"
    static let id = "id"
    static let username = "screen_name"
    static let profilePicture = "profile_image_url_https"
    static let favoritesCount = "favourites_count"
}

let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
let requestToken = "https://api.twitter.com/1.1/statuses/home_timeline.json" + "?tweet_mode=extended"
