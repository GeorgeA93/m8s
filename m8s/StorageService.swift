//
//  StorageService.swift
//  m8s
//
//  Created by George Allen on 20/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class StorageService {
    
    enum Key {
        case Images
    }
    
    private static var images: [Image]!
    private static var handles: [UInt]!
    private static var databaseRef: FIRDatabaseReference!
    private static var subscriptions: [Subscription]!
    
    static func loadItemsFromStorage(){
        subscriptions = [Subscription]()
        handles = [UInt]()
        databaseRef = FIRDatabase.database().reference()
        loadImagesFromStorage()
    }
    
    private static func loadImagesFromStorage() {
        images = [Image]()
        let imagesRef = databaseRef.child("images")
        handles.append(imagesRef.observeEventType(.Value, withBlock: { snapshot in
            print("************ Getting new images **************")
            var newItems = [Image]()
            for item in snapshot.children {
                let imageLocation = item.value["imageLocation"] as! String
                let image = Image(imageLocation: imageLocation, key: item.key)
                newItems.append(image)
                image.loadImage({ error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        images = newItems
                        let imagesSubscriptions = subscriptions.filter({
                            $0.key == Key.Images
                        })
                        for imageSubscription in imagesSubscriptions {
                            imageSubscription.callback()
                        }
                    }
                })
            }
        }));
    }
    
    static func getImageWithKey(key: String) -> Image! {
        for image in images {
            if(image.key == key) {
                return image
            }
        }
        return nil
    }
    
    static func destroy(){
        for handle in handles {
             databaseRef.removeObserverWithHandle(handle)
        }
        subscriptions = [Subscription]()
        images = [Image]()
        handles = [UInt]()
        databaseRef = nil
    }
    
    static func subscribe(key: Key, callback: () -> Void) -> String {
        let subscription = Subscription(key: key, callback: callback)
        subscriptions.append(subscription)
        return subscription.id
    }
    
    static func unsubscribe(id: String) {
        if let index = subscriptions.indexOf({$0.id == id}) {
            subscriptions.removeAtIndex(index)
        }
    }
}