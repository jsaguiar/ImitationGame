//
//  MainViewController.swift
//  Game
//
//  Created by Joao Aguiar on 02/04/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit
import iAd
class MainViewController: UIViewController {
    @IBOutlet weak var bannerView: ADBannerView!

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
