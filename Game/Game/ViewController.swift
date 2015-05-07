//
//  ViewController.swift
//  Game
//
//  Created by Joao Aguiar on 24/03/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit
import GameKit
import iAd

class ViewController: MainViewController,GKGameCenterControllerDelegate, ADBannerViewDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.gameCenter?.authenticateLocalPlayer(self)
        self.canDisplayBannerAds = true
        
        bannerView.delegate = self
        bannerView.alpha = 0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showLeaderBoard(sender: AnyObject) {
        appDelegate.gameCenter?.showLeaderboardAndAchievement(true, vc: self)
    }
    
    
}

