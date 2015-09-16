//
//  Tweet.swift
//  Twitter
//
//  Created by Harley Trung on 9/13/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?

    var raw: NSDictionary
    var entities: NSDictionary?
    var media: [NSDictionary]?
    var mediaURL: String?

    var retweetCount: Int?
    var favoriteCount: Int?
    var isFavorited: Bool?

    static let dateFormatter = NSDateFormatter()

    init(dictionary: NSDictionary) {
        raw = dictionary

        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String

        // TODO: turn formatter into static
        Tweet.dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = Tweet.dateFormatter.dateFromString(createdAtString!)

        entities = raw["entities"] as? NSDictionary
        media = entities?["media"] as? [NSDictionary]
        mediaURL = media?[0]["media_url"] as? String

        retweetCount = raw["retweet_count"] as? Int
        favoriteCount = raw["favorite_count"] as? Int
        isFavorited = raw["favorited"] as? Bool
    }

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
