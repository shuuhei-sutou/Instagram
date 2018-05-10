//
//  PostData.swift
//  Instagram
//
//  Created by USER on 2018/04/27.
//  Copyright © 2018年 shuuhei-sutou. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject{
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var commentName: String?
    var commentCaption: String?
    
    init(snapshot: DataSnapshot, myId: String){
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String]{
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
        self.commentName = valueDictionary["commentName"] as? String
        self.commentCaption = valueDictionary["commentCaption"] as? String
        
    }
}
