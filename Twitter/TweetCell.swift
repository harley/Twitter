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
    @IBOutlet weak var favoriteButton: UIButton!
    var favoriteCount: Int?

    var tweet: Tweet! {
        didSet {
//            println("setting tweet: \(tweet.raw)")
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

            favoriteCount = tweet.raw["favorite_count"] as? Int
            if favoriteCount != nil {
                favoriteCountLabel.text = "\(favoriteCount!)"
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

    // TODO: update via https://dev.twitter.com/rest/reference/post/favorites/create and rerender cell
    @IBAction func onFavoriteFromTimeline(sender: AnyObject) {
        let button = sender as! UIButton

        let image  = UIImage(named: "favorite_on")
        button.setImage(image!, forState: UIControlState.Normal)

        if favoriteCount == nil {
            favoriteCount = 1
        } else {
            favoriteCount = favoriteCount! + 1
        }

        let cell = button.superview?.superview as? TweetCell
        if cell != nil {
            cell!.favoriteCountLabel.text = "\(favoriteCount!)"
        }
    }
}
