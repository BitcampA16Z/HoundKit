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
        var size: CGSize
        
        print("\n\nconfiguring")
        
        // Check if the interaction describes a SendMessageIntent.
        if interaction.intent is INSendMessageIntent {
            // If it is, let's set up a view controller.
            let chatViewController = HKChatViewController()
            chatViewController.queryString = (interaction.intent as! INSendMessageIntent).content
            
            switch interaction.intentHandlingStatus {
                case INIntentHandlingStatus.unspecified, INIntentHandlingStatus.inProgress,INIntentHandlingStatus.ready:
                    print("interaction handling status not done...")
                    print(interaction.intentHandlingStatus.rawValue)
                    chatViewController.isSent = false
                case INIntentHandlingStatus.done:
                    print("interaction handling completed")
                    print(interaction.intentHandlingStatus.rawValue)
                    chatViewController.isSent = true
            }
            
            present(chatViewController, animated: false, completion: nil)
            
            size = desiredSize
        }
        else {
            // Otherwise, we'll tell the host to draw us at zero size.
            print("Is not INSendMessageIntent")
            size = CGSize.zero
        }
        
        completion(size)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
    var displaysMessage: Bool {
        return true
    }
    
}
