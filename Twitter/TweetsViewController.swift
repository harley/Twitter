//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Harley Trung on 9/13/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            println("tweets: \(tweets)")
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
