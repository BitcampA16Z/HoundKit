//
//  HoundKitSendMessageIntentHandler.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import Foundation
import Intents

class HKSendMessageIntentHandler: INExtension, INSendMessageIntentHandling {
    
    let NAME = "Hound"
    let APP_NAME = "HoundKit"
    
        func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: ([INPersonResolutionResult]) -> Swift.Void) {
            print("forcing resolve to recipient: " + NAME)
    
            let hound = INPerson.init(handle: NAME, displayName: NAME, contactIdentifier: NAME)
            let resolutionResults = [INPersonResolutionResult.success(with: hound)]
            completion(resolutionResults)
        }
    
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
    
    func sendMessage(query: String) {
        print("Sending message")
        print(query)
        // Send this message to the API server, retrieve response
        
        var request = URLRequest(url: URL(string: "https://tjakejattl.localtunnel.me/")!)
        request.httpMethod = "POST"
        let postString = "message=" + query
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared().dataTask(with: request) { data, response, error in
            print("returned from URL")
            guard error == nil && data != nil else { // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse where httpStatus.statusCode != 200 { // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        print("resuming task")
        
    }
}
