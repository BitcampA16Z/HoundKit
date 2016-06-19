//
//  HKView.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import UIKit

class HKChatView: UIView {
    
    var mockView: UIImageView
    
    var queryLabel: UILabel
    
    var draftMock: UIImage
    var sentMock: UIImage
    var loadingMock: UIImage
    var houndifyMock: UIImage
    var spotifyMock: UIImage
    
    var previousURL: String?
    
    let DEBUG_COLORS = false
    
    var content: String? {
        willSet(newContent) {
            print("content set")
            print(newContent)
            if newContent != content {
                print("needs layout -- content")
                self.setNeedsLayout()
            }
        }
    }
    
    var jsonResponse: String? {
        willSet(newJSON) {
            print("json set")
            print(newJSON)
            if newJSON != jsonResponse {
                print("needs layout -- jsonresponse")
                self.setNeedsLayout()
            }
        }
    }
    
    var isSent: Boolean = false {
        willSet(newSentValue) {
            mockView.image = newSentValue.boolValue ? sentMock : draftMock
            print("setting isSent: " + isSent.boolValue.description + " -> " + newSentValue.boolValue.description)
            if newSentValue.boolValue != isSent.boolValue {
                print("needs layout -- isSent")
                self.setNeedsLayout()
            }
        }
    }
    
    static func resolveImage(imageName: String) -> UIImage {
        if UIImage(named: imageName) != nil {
            print("image loaded: " + imageName)
            return UIImage(named: imageName)!
        } else {
            fatalError("ERROR: The image named '" + imageName + "' could not be found.")
        }
    }
    
    override init (frame: CGRect) {
        draftMock = HKChatView.resolveImage(imageName: "query2.png")
        spotifyMock = HKChatView.resolveImage(imageName: "spotify-bg.png")
        loadingMock = HKChatView.resolveImage(imageName: "loading-bg.png")
        houndifyMock = HKChatView.resolveImage(imageName: "houndify-bg2.png")
        sentMock = HKChatView.resolveImage(imageName: "chatmock.png")
        
        mockView = UIImageView()
        mockView.contentMode = UIViewContentMode.scaleAspectFill
        
        queryLabel = UILabel()
        
        super.init(frame: frame)
        
        print("isSent value in init: " + (self.isSent.boolValue ? "YES" : "NO"))
        
        addViewContent()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // We don't need this
        fatalError("This class does not support NSCoding")
    }
    
    func addViewContent() {
        // Parse the JSON response and switch on what to render
        var type: String? = nil
        
        var artist = "Unknown Artist"
        var song = "Unknown Song"
        var album = "Unknown Album"
        
        if let jsonString = jsonResponse {
            print(jsonString)
            // Parse out the type
            do {
                let data = jsonString.data(using: String.Encoding.utf8)!
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let artistName = json["artist_name"] as? String {
                    artist = artistName
                }
                if let albumName = json["album_name"] as? String {
                    album = albumName
                }
                if let songName = json["song_name"] as? String {
                    song = songName
                }
                print(artist)
                print(album)
                print(song)
                type = "Spotify"
            } catch {
                print("ERROR JSON SERIALIZING")
            }
        }
        
        self.addSubview(mockView)
        
        if content == nil {
            mockView.image = draftMock
            // We don't have content yet
            // Switch on the type
            queryLabel.frame = CGRect(x: 0.0, y: 0.0, width: 345.0, height: 170.0)
            
            queryLabel.numberOfLines = 0
            queryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            queryLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24.0)
            queryLabel.textAlignment = NSTextAlignment.center
            
            queryLabel.text = "Ask me anything..."
            self.addSubview(queryLabel)
            
            if DEBUG_COLORS {
                queryLabel.backgroundColor = UIColor(red: 0.5, green: 0.1, blue: 0.7, alpha: 0.5)
                queryLabel.layer.borderWidth = 3.0
                queryLabel.layer.borderColor = UIColor(red: 0.5, green: 0.1, blue: 0.7, alpha: 0.8).cgColor
            }
        } else if type == nil {
            // We haven't received a response yet: loading
            mockView.image = loadingMock
            
        } else {
            // We have a response from the server and need to switch on the type to render a specific view
            switch type {
            default:
//                print("ERROR: This type is not currently handled by HKChatView: " + type!)
                mockView.image = spotifyMock
                
                let albumImageView: UIImageView = UIImageView(frame: CGRect(x: 10.0, y: 10.0, width: 120.0, height: 120.0))
                albumImageView.layer.borderWidth = 3.0
                albumImageView.layer.borderColor = UIColor.black().cgColor
                albumImageView.image = HKChatView.resolveImage(imageName: "album-placeholder.png")
                self.addSubview(albumImageView)
                
                let albumLabel = UILabel()
                albumLabel.numberOfLines = 1
                albumLabel.font = UIFont(name: "KohinoorBangla-Regular", size: 20.0)
                albumLabel.textAlignment = NSTextAlignment.left
                albumLabel.text = album
                albumLabel.frame = CGRect(x: 140.0, y: 90.0, width: 305.0, height: 40.0)
                self.addSubview(albumLabel)
                
                
                let artistLabel = UILabel()
                artistLabel.numberOfLines = 1
                artistLabel.font = UIFont(name: "KohinoorBangla-Regular ", size: 24.0)
                artistLabel.textAlignment = NSTextAlignment.left
                artistLabel.text = artist
                artistLabel.frame = CGRect(x: 140.0, y: 50.0, width: 305.0, height: 40.0)
                self.addSubview(artistLabel)
                
                
                let songLabel = UILabel()
                songLabel.numberOfLines = 1
                songLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24.0)
                songLabel.textAlignment = NSTextAlignment.left
                songLabel.text = song
                songLabel.frame = CGRect(x: 140.0, y: 10.0, width: 305.0, height: 40.0)
                self.addSubview(songLabel)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("laying out subviews")
        print(content)
        mockView.frame = self.bounds
        
        addViewContent()
    }
}
