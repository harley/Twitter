//
//  TwitterClient.swift
//  Twitter
//
//  Created by Harley Trung on 9/12/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit


let twitterConsumerKey = "Tp1vRzSGHfUmAk6SD4AA"
let twitterConsumerSecret = "ma1b1Guq76I2fUrDys33t0g2ift2InV0cWRJV4NY"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

   static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

    var loginCompletion: ((user: User?, error: NSError?) -> ())?

    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        println("homeTimeline")
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            println("Loaded \(tweets.count) tweets")
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting timeline")
                completion(tweets: nil, error: error)
        })
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion

        // fetch request token and redirect to authentication page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()

        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth")!, scope: nil, success: { (requestToken) -> Void in
            println("got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")

            UIApplication.sharedApplication().openURL(authURL!)

        }) { (error) -> Void in
                println("Error getting the request token: \(error)")
            self.loginCompletion?(user: nil, error: error)
        }
    }

    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)

            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)

                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                })
            }) { (error: NSError!) -> Void in
                println("Failed to receive access token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }

    }
}
