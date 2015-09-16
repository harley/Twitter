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

        tweetTextLabel.text = tweet.text
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width

        if let user = tweet.user {
            let profileImageUrl = user.profileImageUrl
            if profileImageUrl != nil {
                profilePicImageView.setImageWithURL(NSURL(string: profileImageUrl!))
            }
            userNameLabel.text = user.name
            userHandleLabel.text = "@\(user.screenName!)"
        }

        if let retweetCount = tweet.retweetCount {
            retweetCountLabel.text = "\(retweetCount)"
        }

        if let favoriteCount = tweet.favoriteCount {
            favoriteCountLabel.text = "\(favoriteCount)"
        }

        if tweet.mediaURL != nil {
            tweetImageView.setImageWithURL(NSURL(string: tweet.mediaURL!))
        } else {
            tweetImageView.image = UIImage()
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
