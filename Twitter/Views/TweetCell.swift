//
//  TweetCell.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var numReplies: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var numRetweets: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var images: UIView!

    @IBOutlet weak var imageToBottom: NSLayoutConstraint!
    @IBOutlet weak var labelToImage: NSLayoutConstraint!
    @IBOutlet weak var labelToBottom: NSLayoutConstraint!
    @IBOutlet weak var img1Height: NSLayoutConstraint!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    
    
    var tweet: Tweet! {
        didSet {
            let tweetText = tweet.text!
            var tweetTextNS = tweet.text! as NSString
            tweetTextNS = tweetTextNS.replacingOccurrences(of: urlRegEx, with: "", options: .regularExpression, range: NSRange(location: tweetText.startIndex.encodedOffset, length: tweetText.endIndex.encodedOffset)) as NSString
            let trimmedTweet = tweetTextNS as String
            tweetBody.text = tweetText//trimmedTweet
            numRetweets.text = String(tweet.retweetCount!)
            numLikes.text = String(tweet.favoriteCount!)
            time.text = tweet.timeStamp
            favorited = tweet.favorited!
            retweeted = tweet.retweeted!
            setLike()
            loadImages()
            
        }
    }
    
    var user: User! {
        didSet {            
            profilePic.image = getImage(imageURL: user.profilePicture!)
            displayName.text = user.displayName
            username.text = "@\(user.username!)"
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderWidth = 1
        profilePic.layer.borderColor = #colorLiteral(red: 0.1148733422, green: 0.6306492686, blue: 0.9478885531, alpha: 1)
        
        image1.layer.cornerRadius = 10
        image1.clipsToBounds = true
        image2.layer.cornerRadius = 10
        image2.clipsToBounds = true
        image3.layer.cornerRadius = 10
        image3.clipsToBounds = true
        image4.layer.cornerRadius = 10
        image4.clipsToBounds = true
        
        numReplies.isHidden = true
        replyButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getImage(imageURL: URL) -> UIImage {
        var image = UIImage()
        let data = try? Data(contentsOf: imageURL)
        if let imageData = data {
            image = UIImage(data: imageData)!
        }
        return image
    }
    
    func setLike() {
        if(favorited) {
            likeButton.setImage(UIImage.init(named:  "favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage.init(named:  "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet() {
        if(retweeted) {
            retweetButton.setImage(UIImage.init(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else {
            retweetButton.setImage(UIImage.init(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweet.id!, success: {
                self.retweeted = !self.retweeted
                self.setRetweet()
            }, failure: { (Error) in
                print(Error.localizedDescription)
            })
        } else {
            TwitterAPICaller.client?.unRetweet(tweetId: tweet.id!, success: {
                self.retweeted = !self.retweeted
                self.setRetweet()
            }, failure: { (Error) in
                print(Error.localizedDescription)
            })
        }
    }
    
    @IBAction func like(_ sender: Any) {
        let toBeLiked = !favorited
        if (toBeLiked) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweet.id!, success: {
                self.favorited = !self.favorited
                self.setLike()
            }, failure: { (Error) in
                print(Error.localizedDescription)
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweet.id!, success: {
                self.favorited = !self.favorited
                self.setLike()
            }, failure: { (Error) in
                print(Error.localizedDescription)
            })
        }
    }
    
    func loadImages() {
        if (tweet.mediaPresent) {
            switch tweet.urls.count {
            case 0:
                images.isHidden = true
            case 1:
                image1.isHidden = false
                let mediaURL = tweet.urls[0]
                image1.image = getImage(imageURL: mediaURL)
                image2.isHidden = true
                image3.isHidden = true
                image4.isHidden = true
                
            case 2:
                image1.isHidden = false
                let mediaURL1 = tweet.urls[0]
                image1.image = getImage(imageURL: mediaURL1)
                image2.isHidden = false
                let mediaURL2 = tweet.urls[1]
                image2.image = getImage(imageURL: mediaURL2)
                image3.isHidden = true
                image4.isHidden = true
            case 3:
                image1.isHidden = false
                let mediaURL1 = tweet.urls[0]
                image1.image = getImage(imageURL: mediaURL1)
                image2.isHidden = false
                let mediaURL2 = tweet.urls[1]
                image2.image = getImage(imageURL: mediaURL2)
                image3.isHidden = false
                let mediaURL3 = tweet.urls[2]
                image3.image = getImage(imageURL: mediaURL3)
                image4.isHidden = true
            case 4:
                image1.isHidden = false
                let mediaURL1 = tweet.urls[0]
                image1.image = getImage(imageURL: mediaURL1)
                image2.isHidden = false
                let mediaURL2 = tweet.urls[1]
                image2.image = getImage(imageURL: mediaURL2)
                image3.isHidden = false
                let mediaURL3 = tweet.urls[2]
                image3.image = getImage(imageURL: mediaURL3)
                image4.isHidden = false
                let mediaURL4 = tweet.urls[3]
                image4.image = getImage(imageURL: mediaURL4)
            default:
                images.isHidden = true
            }
        } else {
            images.isHidden = true
            img1Height.constant = 0
            imageToBottom.isActive = false
            labelToImage.isActive = false
            labelToBottom.isActive = true
        }
    }
    
}
