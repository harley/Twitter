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

    var tweet: Tweet! {
        didSet {
            println("setting tweet: \(tweet.raw)")
            tweetTextLabel.text = tweet.text
            let profileImageUrl = tweet.user?.profileImageUrl
            if profileImageUrl != nil {
                profilePicImageView.setImageWithURL(NSURL(string: profileImageUrl!))
            }
            userNameLabel.text = tweet.user?.name
            userHandleLabel.text = "@\(tweet.user!.screenName!)"

            if let retweetCount = tweet.raw["retweet_count"] as? Int {
                retweetCountLabel.text = "\(retweetCount)"
            }
            if let favoritesCount = tweet.raw["favourites_count"] as? Int {
                favoriteCountLabel.text = "\(favoritesCount)"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
