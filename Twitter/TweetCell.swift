//
//  TweetCell.swift
//  Twitter
//
//  Created by Harley Trung on 9/13/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!

    var tweet: Tweet! {
        didSet {
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
            timeAgoLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()

            let media = tweet.raw.valueForKeyPath("entities.media") as? NSArray
            if media != nil {
                let media0 = media?.firstObject as! NSDictionary
                let mediaURL = media0["media_url"] as? String
                if  mediaURL != nil {
                    tweetImageView.setImageWithURL(NSURL(string: mediaURL!))
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        profilePicImageView.layer.cornerRadius = 5
        profilePicImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // may not be necessary (but it's required on line 25)
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
}
