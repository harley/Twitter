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
    var refreshControl:UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTweets(refreshing: false)

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        tableView.addSubview(refreshControl)

        // change indicator view style to white
//        tableView.infiniteScrollIndicatorStyle = .White

        // Add infinite scroll handler
        tableView.addInfiniteScrollWithHandler { (scrollView) -> Void in
            let tableView = scrollView as! UITableView

            //
            // fetch your data here, can be async operation,
            // just make sure to call finishInfiniteScroll in the end
            //
            self.loadMoreTweets()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "singleTweetSegue" {
            let cell = sender as? TweetCell
            let indexPath = tableView.indexPathForCell(cell!)
            println("clicking on \(indexPath!.row)")

            let vc = segue.destinationViewController as! TweetViewController
            vc.tweet = cell?.tweet
        } else if segue.identifier == "composeSegue" {
            if sender is UIButton {
                let retweetButton = sender as! UIButton
                let cell = retweetButton.superview?.superview as? TweetCell

                if cell != nil {
                    let indexPath = tableView.indexPathForCell(cell!)
                    let tweet = cell!.tweet
                    let vc = segue.destinationViewController as! ComposeViewController
                    vc.replyToTweet = tweet
                    vc.replyToUser = tweet.user
                }
            }
        }
    }


    // MARK: - Pull to refresh


    func refresh(sender: AnyObject) {
        //        println(sender)
        loadTweets(refreshing: true)
    }

    func loadTweets(refreshing: Bool = false) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            println("first tweet: \(tweets?.first?.text)")
            self.tableView.reloadData()

            if refreshing {
                self.refreshControl.endRefreshing()
            }
        })
    }

    @IBAction func onReplyFromTimeline(sender: AnyObject) {
        performSegueWithIdentifier("composeSegue", sender: sender)
    }

    func loadMoreTweets(){
        let tweetId = tweets?.last?.raw["id"] as! NSNumber
        let params = ["max_id": tweetId]

        TwitterClient.sharedInstance.homeTimelineWithParams(params, completion: { (newTweets, error) -> () in
            println("[loadMoreTweets] \(newTweets?.count) tweets; error: \(error); self.tweets: \(self.tweets?.count) tweets")
            if var newTweets = newTweets {
                self.tweets?.removeLast() // remove the last tweet before appending because the result should contain it (maxId)
                self.tweets!.extend(newTweets)
                println("loadMoreTweets's first: \(newTweets.first?.text)")
                self.tableView.reloadData()
            } else {
                println("Error loading MORE from timeline: \(error)")
            }

            self.tableView.finishInfiniteScroll()

        })
    }
}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }

    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row] as Tweet

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}