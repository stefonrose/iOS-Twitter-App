//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

var numberOfTweets: Int!

class HomeTableViewController: UITableViewController {

    var TweetArray = [Tweet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        tableView.estimatedRowHeight = 100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }
    
    func loadTweets() {
        numberOfTweets = 20
        let params = ["count": numberOfTweets!]
        TwitterAPICaller.client?.getDictionariesRequest(url: requestToken, parameters: params, success: { (tweets: [NSDictionary]) in
            self.TweetArray.removeAll()
            for tweet in tweets {
                self.TweetArray.append(Tweet(dictionary: tweet))
                self.tableView.reloadData()
            }
        }, failure: { (Error) in
            print("There was an error: \(Error.localizedDescription)")
        })
    }
    
    func loadMoreTweets(){
        numberOfTweets = numberOfTweets + 20
        let params = ["count": numberOfTweets!]
        TwitterAPICaller.client?.getDictionariesRequest(url: requestToken, parameters: params, success: { (tweets: [NSDictionary]) in
            self.TweetArray.removeAll()
            for tweet in tweets {
                self.TweetArray.append(Tweet(dictionary: tweet))
                self.tableView.reloadData()
            }
        }, failure: { (Error) in
            print("There was an error: \(Error.localizedDescription)")
        })
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let tweet = TweetArray[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet.user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == TweetArray.count {
            loadMoreTweets()
        }
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
