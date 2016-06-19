//
//  IntentViewController.swift
//  HoundKitSiriExtensionUI
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INStartWorkoutIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Start my workout using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling, INUIHostedViewSiriProviding {
    
    var chatViewController: HKChatViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configure(with interaction: INInteraction!, context: INUIHostedViewContext, completion: ((CGSize) -> Void)!) {
        
        print("\n\nconfiguring")
        
        // Check if the interaction describes a SendMessageIntent.
        if interaction.intent is INSendMessageIntent {
            // If it is, let's set up a view controller.
            if (chatViewController == nil) {
                print("init-ing view controller in intentVC")
                chatViewController = HKChatViewController()
                present(chatViewController!, animated: false, completion: nil)
            }
            
            let content = (interaction.intent as! INSendMessageIntent).content
            chatViewController!.queryString = content
            if content != nil {
                print("Content: " + content!)
                let serverURL = "https://colinkinghoundkit.localtunnel.me/"
                var request = URLRequest(url: URL(string: serverURL)!)
                request.httpMethod = "POST"
                let postString = "message=" + content!
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
                    
                    self.chatViewController!.jsonResponse = responseString
                    
                    completion(self.desiredSize)
                }
                task.resume()
                print("resuming task to " + serverURL + " for query: " + content!)
            } else {
                print("No content -- not sending request to server")
                completion(desiredSize)
            }
            
            
            
//            switch interaction.intentHandlingStatus {
//                case INIntentHandlingStatus.unspecified, INIntentHandlingStatus.inProgress,INIntentHandlingStatus.ready:
//                    print("interaction handling status not done...")
//                    print(interaction.intentHandlingStatus.rawValue)
//                    chatViewController!.isSent = false
//                case INIntentHandlingStatus.done:
//                    print("interaction handling completed")
//                    print(interaction.intentHandlingStatus.rawValue)
//                    chatViewController!.isSent = true
//            }
            
        }
        else {
            // Otherwise, we'll tell the host to draw us at zero size.
            print("Is not INSendMessageIntent")
            completion(CGSize.zero)
        }
        
        
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
    var displaysMessage: Bool {
        return true
    }
    
}
