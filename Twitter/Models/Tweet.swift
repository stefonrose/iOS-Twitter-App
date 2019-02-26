//
//  Tweet.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var id: Int?                 // For favoriting, retweeting & replying
    var user: User?                // Author of the Tweet
    var text: String?              // Text content of tweet
    var favoriteCount: Int?        // Update favorite count label
    var favorited: Bool?           // Configure favorite button
    var retweetCount: Int?         // Update favorite count label
    var retweeted: Bool?           // Configure retweet button
    var timeStamp: String?         // String representation of date posted
    
    var mediaPresent: Bool = false
    var truncated: Bool?
    var numMedia: Int?
    var urls: [URL] = []
    
    var ogText: String?
    
    var retweetedByUser: User?     // For retweets
    
    init(dictionary: NSDictionary) {
        super.init()
        var dictionary = dictionary
        
        // Check if this is a retweet
        if let originTweet = dictionary[tweetKeys.retStatus] as? NSDictionary {
            let user = dictionary[tweetKeys.user] as? NSDictionary
            self.retweetedByUser = User(dictionary: user!)
            ogText = dictionary["text"] as? String
            dictionary = originTweet
        }
        
        let userDictionary = dictionary[tweetKeys.user] as! NSDictionary
        let timeString = dictionary[tweetKeys.created] as! String
        
        id = dictionary[tweetKeys.id] as? Int
        text = dictionary[tweetKeys.text] as? String
        user = User(dictionary: userDictionary)
        timeStamp = formatDate(createdAt: timeString)
        favorited = dictionary[tweetKeys.favStatus] as? Bool
        retweeted = dictionary[tweetKeys.retStatus] as? Bool
        favoriteCount = dictionary[tweetKeys.favCount] as? Int
        retweetCount = dictionary[tweetKeys.retCount] as? Int
        truncated = dictionary[tweetKeys.trunc] as? Bool
        
        if let extended = dictionary[tweetKeys.extend] as? NSDictionary {
            var thisURL: URL?
            let media = extended[tweetKeys.media] as! [Any]
            numMedia = media.count
            for case let item as NSDictionary in media {
                let URLString = item[tweetKeys.mediaURL] as! String
                let type = item[tweetKeys.type] as! String
                if type == "photo" {
                    thisURL = URL(string: URLString)
                    urls.append(thisURL!)
                    mediaPresent = true
                }
            }
        }
    }
    
     func formatDate(createdAt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = formatter.date(from: createdAt)!
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
}
