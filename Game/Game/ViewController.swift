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

class ViewController: UIViewController,GKGameCenterControllerDelegate, ADBannerViewDelegate{
    
    @IBOutlet weak var bannerView: ADBannerView!
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
    
    
    //BannerView delegate
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
    }
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        println("add loaded")
        
        UIView.animateWithDuration(0.5, animations: {
                self.bannerView.alpha = 1
            }
            , completion: nil)
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("error loading \(error.description)")
        
        UIView.animateWithDuration(0.5, animations: {
            self.bannerView.alpha = 0
            }
            , completion: nil)

    }
}

