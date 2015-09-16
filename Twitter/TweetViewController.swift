//
//  TweetViewController.swift
//  Twitter
//
//  Created by Harley Trung on 9/15/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!

    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        println("setting tweet: \(tweet.raw)")
        tweetTextLabel.text = tweet.text
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width

        let profileImageUrl = tweet.user?.profileImageUrl
        if profileImageUrl != nil {
            profilePicImageView.setImageWithURL(NSURL(string: profileImageUrl!))
        }
        userNameLabel.text = tweet.user?.name
        userHandleLabel.text = "@\(tweet.user!.screenName!)"

        if let retweetCount = tweet.raw["retweet_count"] as? Int {
            retweetCountLabel.text = "\(retweetCount)"
        }
        if let favoritesCount = tweet.raw["favorite_count"] as? Int {
            favoriteCountLabel.text = "\(favoritesCount)"
        }
        //            timeAgoLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()

        let media = tweet.raw.valueForKeyPath("entities.media") as? NSArray
        if media != nil {
            let media0 = media?.firstObject as! NSDictionary
            let mediaURL = media0["media_url"] as? String
            if  mediaURL != nil {
                tweetImageView.setImageWithURL(NSURL(string: mediaURL!))
            }
        }

        timestampLabel.text = NSDateFormatter.localizedStringFromDate(tweet.createdAt!, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    

}
