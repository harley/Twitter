//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Harley Trung on 9/14/15.
//  Copyright (c) 2015 Harley Trung. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var composeTextField: UITextField!
    @IBOutlet weak var remainingCharCountLabel: UILabel!

    @IBOutlet weak var tweetButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileImageUrl = User.currentUser?.profileImageUrl
        if profileImageUrl != nil {
            profileImageView.setImageWithURL(NSURL(string: profileImageUrl!))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateRemainingCharCount(sender: AnyObject) {
        let soFar = count(composeTextField.text)
        let remaining = 140 - soFar
        remainingCharCountLabel.text = "\(remaining)"
    }

    @IBAction func onTweet(sender: AnyObject) {
        println("tweeting: \(composeTextField.text)")

        let params = ["status": composeTextField.text]
        TwitterClient.sharedInstance.postTweetWithParams(params, completion: { (status, error) -> () in
            if error != nil {
                println("error tweeting: \(error)")
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }

        })
    }

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
