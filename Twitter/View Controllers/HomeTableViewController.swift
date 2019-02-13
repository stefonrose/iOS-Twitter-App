//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var TweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        print(TweetArray.count)
    }
    
    func loadTweets() {
        let requestToken = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 20]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: requestToken, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.TweetArray.removeAll()
            for tweet in tweets {
                self.TweetArray.append(tweet)
                self.tableView.reloadData()
            }
        }, failure: { (Error) in
            print("There was an error: \(Error.localizedDescription)")
        })
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let tweet = TweetArray[indexPath.row]
        let user = tweet["user"] as? NSDictionary
        let profilePic = user?["profile_image_url_https"] as? String
        let profilePicURL = URL(string: profilePic!)
        let data = try? Data(contentsOf: profilePicURL!)
        
        if let imageData = data {
            cell.profilePic.image = UIImage(data: imageData)
        }
        
        cell.displayName.text = user?["name"] as? String
        cell.username.text = user?["screen_name"] as? String
        cell.tweetBody.text = tweet["text"] as? String
        
        return cell
    }
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TweetArray.count
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "currentUser")
        self.dismiss(animated: true, completion: nil)
    }
    
}
