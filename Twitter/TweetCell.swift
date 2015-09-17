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

    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width

            let profileImageUrl = tweet.user?.profileImageUrl
            if profileImageUrl != nil {
                profilePicImageView.setImageWithURL(NSURL(string: profileImageUrl!))
            }
            userNameLabel.text = tweet.user?.name
            userHandleLabel.text = "@\(tweet.user!.screenName!)"

            if let retweetCount = tweet.retweetCount {
                retweetCountLabel.text = "\(retweetCount)"
            }

            if let favoriteCount = tweet.favoriteCount {
                favoriteCountLabel.text = "\(favoriteCount)"
            }

            timeAgoLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()

            if  tweet.mediaURL != nil {
                tweetImageView.setImageWithURL(NSURL(string: tweet.mediaURL!))
            } else {
                tweetImageView.image = nil
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        profilePicImageView.layer.cornerRadius = 5
        profilePicImageView.clipsToBounds = true
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
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

        var favoriteCount = tweet.favoriteCount ?? 0
        favoriteCount = favoriteCount + 1

        if let cell = button.superview?.superview as? TweetCell {
            cell.favoriteCountLabel.text = "\(favoriteCount)"
        }
    }
}
