//
//  MultiplayerViewController.swift
//  Game
//
//  Created by Joao Aguiar on 04/04/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit
import GameKit
protocol MultiplayerDelegate{
    func matchStarted()
    func matchEnded()
    func match(match:GKMatch, didReceiveData data:NSData, fromPlayer playerID:String)
    
}


class MultiplayerViewController: NSObject, GKMatchmakerViewControllerDelegate  /*gkturnedbased...*/{
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var matchStarted = false
    var match:GKMatch?
    var delegate:MultiplayerDelegate?
    
    override init(){
        
    }
    
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFindMatch match: GKMatch!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        self.match = match
       // match.delegate = self;
        
        if !matchStarted && match.expectedPlayerCount == 0{
            println("Ready to start match")
        }
        
    }
    
    
    
    func matchmakerViewControllerWasCancelled(viewController: GKMatchmakerViewController!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFailWithError error: NSError!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        println("Multiplayer: \(error.description)")
    }
    
    
    func findMatchWithMinPlayers(minPlayers:Int, maxPlayers:Int, viewController:UIViewController, delegate:MultiplayerDelegate) {
        if ((appDelegate.gameCenter?.gameCenterEnabled) != false) {
            return
        }
        
        matchStarted = false
        self.match = nil
        self.delegate = delegate
        viewController.dismissViewControllerAnimated(false, completion:nil)
        
        let request = GKMatchRequest()
        request.minPlayers = minPlayers;
        request.maxPlayers = maxPlayers;
        
        let mmvc = GKMatchmakerViewController(matchRequest: request)
        mmvc.matchmakerDelegate = self
        
        viewController.presentViewController(mmvc, animated:true, completion:nil)
    }
    
    
}
