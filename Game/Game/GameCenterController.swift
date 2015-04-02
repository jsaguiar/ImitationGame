//
//  GameCenterController.swift
//  Game
//
//  Created by Joao Aguiar on 26/03/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit
import GameKit

class GameCenterController {
    
    var gameCenterEnabled = false
    var leaderboardIdentifier:String?
    
    init(){
    }
    
    func authenticateLocalPlayer( vc:UIViewController )
    {
        var localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            
            (viewController : UIViewController!, error : NSError!) -> Void in
            
            if viewController != nil
            {
                vc.presentViewController(viewController, animated:true, completion: nil)
            }
            else
            {
                if localPlayer.authenticated
                {
                    self.gameCenterEnabled = true
                    localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler
                        { (leaderboardIdentifier, error) -> Void in
                            if error != nil
                            {
                                print("error")
                            }
                            else
                            {
                                self.leaderboardIdentifier = leaderboardIdentifier
                                println("\(self.leaderboardIdentifier)") //in your example "VHS" should be returned
                            }
                    }
                }
                else
                {
                    println("not able to authenticate fail")
                    self.gameCenterEnabled = false
                    
                    if (error != nil)
                    {
                        println("\(error.description)")
                    }
                    else
                    {
                        println(    "error is nil")
                    }
                }
            }
        }
    }
    
    
    
    
    func reportScore (level:Int){
        if (!gameCenterEnabled){
            return
        }
        let score = GKScore(leaderboardIdentifier: self.leaderboardIdentifier)
        score.value = Int64(level)
        var scoreArray: [GKScore] = [score]
        GKScore.reportScores(scoreArray, {(error : NSError!) -> Void in
            if error != nil {
                NSLog(error.localizedDescription)
            }
        })
    }
    
    
    
    func showLeaderboardAndAchievement(shouldShowLeaderboard:Bool,vc:ViewController){
        let gcViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = vc
        
        if (shouldShowLeaderboard) {
            gcViewController.viewState = .Leaderboards
            gcViewController.leaderboardIdentifier = leaderboardIdentifier;
        }
        else{
            gcViewController.viewState = .Achievements
        }
        
        vc.presentViewController(gcViewController, animated: true, completion: nil)
    }
    
    
    func levelAchivement(level:Int){
        var progressPercentage:Double = 0.0
        var progressInLevelAchievement = false
        var achievementIdentifier:String?
        var achivements = [GKAchievement]()
        
        if (level <= 10){
            progressPercentage = Double(level*100/10)
            achievementIdentifier = "Achievement_Level_10"
            progressInLevelAchievement = true
        }
        
        if (progressInLevelAchievement){
            let levelAchievement = GKAchievement(identifier: achievementIdentifier!)
            levelAchievement.percentComplete = progressPercentage
            achivements.append(levelAchievement)
        }
        GKAchievement .reportAchievements(achivements, withCompletionHandler: {(error : NSError!) -> Void in
            if error != nil {
                NSLog(error.localizedDescription)
            }
        })
        
    }
    
    //USE ONLY FOR TESTING -> NOT REVERSABLE
    func resetAchivements(){
        GKAchievement.resetAchievementsWithCompletionHandler({(error:NSError!) -> Void in
            if error != nil {
                println(error.localizedDescription)
            }
        })
        
    }
    
}