//
//  TweetViewController.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/25/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {


    @IBOutlet weak var composeBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeBox.becomeFirstResponder()
        composeBox.layer.borderWidth = 1
        composeBox.layer.borderColor = #colorLiteral(red: 0, green: 0.6420029998, blue: 0.9800850749, alpha: 1)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if (!composeBox.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: composeBox.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print(Error.localizedDescription)
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
