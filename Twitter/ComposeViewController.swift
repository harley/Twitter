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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
