//
//  HoundKitSendMessageIntentHandler.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import Foundation
import Intents

class HoundKitSendMessageIntentHandler: INExtension, INSendMessageIntentHandling {
    
    let NAME = "Hound"
    let APP_NAME = "HoundKit"
    
//    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: ([INPersonResolutionResult]) -> Swift.Void) {
//        print("forcing resolve to recipient: " + NAME)
//        
//        let hound = INPerson.init(handle: NAME, displayName: NAME, contactIdentifier: NAME)
//        let resolutionResults = [INPersonResolutionResult.success(with: hound)]
//        completion(resolutionResults)
//    }
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: (INStringResolutionResult) -> Swift.Void) {
        print("resolving content")
        if let text = intent.content where !text.isEmpty {
            print("received text...")
            print(text)
            completion(INStringResolutionResult.success(with: text))
        }
        else {
            print("needs content")
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func handle(sendMessage intent: INSendMessageIntent, completion: (INSendMessageIntentResponse) -> Void) {
        print("Message intent is being handled.")
        if let query = intent.content {
            sendMessage(query: query)
        } else {
            print("ERROR: Empty message")
        }
        let userActivity: NSUserActivity? = nil // NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent))
        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    
    func sendMessage(query: NSString) {
        print("Sending message")
        print(query)
        // Send this message to the API server, retrieve response
        
    }
}
