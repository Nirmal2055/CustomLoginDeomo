//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by Nirmal Koirala on 18/07/2022.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        setUpElements()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        set up video in the background
        
        setUpVideo()
    }
    
    func setUpElements() {

        
//        style the elements
        
        Utilities.styledFilledButton(signUpButton)
        Utilities.styledFilledButton(loginButton )
    }
    
    func setUpVideo() {
        
//        get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
//        create the URL from it
        
        let url = URL(fileURLWithPath: bundlePath!)
        
//        create the video player item
        let item = AVPlayerItem(url: url)
//        create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        
//        create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
//        adjust the size and frame
        
        videoPlayerLayer?.frame = CGRect(x:
                                           -self.view.frame.size.width*1, y: 0, width:
                                            self.view.frame.size.width*3, height:
                                            self.view.frame.size.height/2)
                                            view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
//        Add it to the view and play it
        
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    

}

