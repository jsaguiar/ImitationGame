//
//  GameViewController.swift
//  Game
//
//  Created by Joao Aguiar on 24/03/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController,UIGestureRecognizerDelegate {
    
    let blueBtnColor = UIColor(red: 0.0, green: 0.0, blue: 1, alpha: 1)
    let redBtnColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 1)
    let greenBtnColor = UIColor(red: 0.0, green: 1, blue: 0.0, alpha: 1)
    let yellowBtnColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
    let defaultColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    
    let animationTime = 0.5
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var gameOverView: ILTranslucentView!
    @IBOutlet weak var levelLostLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    
    var sadImage:UIImageView = UIImageView(image:UIImage(named: "sad63.png"))
    var happyImage:UIImageView = UIImageView(image:UIImage(named: "emoticon5.png"))
    
    var playingArray:[Int]=[]
    var animatingPress:Int=0
    var numberOfPlayerPress:Int=0
    var showingAnimtation:Bool=false
    var lives:Int=3
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden=true
        
        self.centerView.layer.cornerRadius = 50
        self.centerView.layer.masksToBounds = true
        self.centerLabel.text = "1"
        
        //init gameOverView
        gameOverView.backgroundColor = UIColor.clearColor()
        gameOverView.tintColor = UIColor.clearColor()
        gameOverView.translucentAlpha = 1.0
        gameOverView.translucentStyle = UIBarStyle.Black
        
        self.sadImage.frame = self.centerView.bounds
        self.sadImage.clipsToBounds = true
        self.sadImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.happyImage.frame = self.centerView.bounds
        self.happyImage.clipsToBounds = true
        self.happyImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        
    }
    
    func reinitGame() {
        self.centerLabel.text = "1"
        self.blueView.backgroundColor=blueBtnColor
        self.redView.backgroundColor=redBtnColor
        self.greenView.backgroundColor=greenBtnColor
        self.yellowView.backgroundColor=yellowBtnColor
        playingArray.removeAll(keepCapacity: false)
        playingArray=[]
        animatingPress=0
        numberOfPlayerPress=0
        showingAnimtation=false
        lives=3
        self.livesLabel.text = "\(lives)"
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startLevel()
    }
    
    func replay(){
        self.numberOfPlayerPress = 0
        self.animatingPress=0
        self.showingAnimtation = true
        var dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.animatePress(self.playingArray[self.animatingPress])
        })
        
    }
    
    func startLevel(){
        self.numberOfPlayerPress=0
        var a:Int = Int(arc4random_uniform(425)) % 4
        println(a)
        self.playingArray.append(a)
        self.centerLabel.text = "\(self.playingArray.count)"
        
        self.animatingPress=0
        self.showingAnimtation = true
        
        appDelegate.gameCenter?.levelAchivement(self.playingArray.count)
        var dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.animatePress(self.playingArray[self.animatingPress])
        })
    }
    
    func animatePress(viewInt:Int ){
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                let view = self.getViewFromInteger(viewInt)
                view.backgroundColor=self.defaultColor
            },
            completion: { finished in
                self.animateUnpress(viewInt)
        })
    }
    
    func animateUnpress(viewInt:Int){
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                let view = self.getViewFromInteger(viewInt)
                view.backgroundColor=self.getColorForiewFromInteger(viewInt)
            },
            completion: { finished in
                self.endedAnimation()
        })
    }
    func endedAnimation(){
        animatingPress++
        if animatingPress < self.playingArray.count{
            animatePress(self.playingArray[animatingPress])
        }else{
            showingAnimtation = false
        }
    }
    
    func getViewFromInteger(i:Int) -> UIView{
        switch (i) {
        case 1:
            return blueView
        case 2:
            return redView
        case 3:
            return greenView
        default:
            return yellowView
        }
    }
    func getColorForiewFromInteger(i:Int) -> UIColor{
        switch (i) {
        case 1:
            return blueBtnColor
        case 2:
            return redBtnColor
        case 3:
            return greenBtnColor
        default:
            return yellowBtnColor
        }
    }
    
    //gameLogic

    func loseRound(){
        self.lives--
        AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate));
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                self.centerLabel.hidden = true
                self.centerView.backgroundColor = UIColor.redColor()
                self.centerView.addSubview(self.sadImage)
                self.livesLabel.text = "\(self.lives)"
            },
            completion: { finished in
                
                UIView.animateWithDuration(self.animationTime/2,
                    delay: 0.0,
                    options: .CurveEaseInOut,
                    animations: {
                        self.centerLabel.hidden = false
                        self.centerView.backgroundColor = UIColor.whiteColor()
                        self.sadImage.removeFromSuperview()
                    },
                    completion: {finished in self.handleLoseRound()
                })
        })
        
        
        
    }
    
    func handleLoseRound(){
        if (lives>0){
            self.replay()
            
        }else{
           self.gameOver()
        }

    }
  
    func gameOver(){
        self.view.bringSubviewToFront(self.gameOverView)
        self.levelLostLabel.text = "Level \(self.playingArray.count)"
        
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                self.gameOverView.alpha = 1
            },
            completion:nil)

        
        appDelegate.gameCenter?.reportScore(self.playingArray.count)
        
        Chartboost.showInterstitial(CBLocationHomeScreen)

    }
    
    
    func nextRound(){
        self.centerLabel.text = "\(self.playingArray.count+1)"
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                self.centerLabel.hidden = true
                self.centerView.backgroundColor = UIColor.greenColor()
                self.centerView.addSubview(self.happyImage)
                
            },
            completion: { finished in
                UIView.animateWithDuration(self.animationTime/2,
                    delay: 0.0,
                    options: .CurveEaseInOut,
                    animations: {
                        self.centerLabel.hidden = false
                        self.centerView.backgroundColor = UIColor.whiteColor()
                        self.happyImage.removeFromSuperview()
                    },
                    completion: {finished in self.startLevel()
                })
        })

      
    }
    
    func verifieCorrectInput(input:Int){
        
        if showingAnimtation || numberOfPlayerPress >= self.playingArray.count{
            return
        }
        if self.playingArray[numberOfPlayerPress] != input {
            showingAnimtation = true
            loseRound()
        }else{
            numberOfPlayerPress++
            if numberOfPlayerPress >= self.playingArray.count{
                nextRound()
            }
        }
    }
    
    //gestures recongizer
    
    func userPressAnimation(viewInt:Int){
        if showingAnimtation{
            return
        }
        
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                let view = self.getViewFromInteger(viewInt)
                view.backgroundColor=self.defaultColor
            },
            completion: nil
        )
    }
    
    
    func userUnpressAnimation(viewInt:Int){
        if showingAnimtation{
            return
        }
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut | .AllowUserInteraction,
            animations: {
                let view = self.getViewFromInteger(viewInt)
                view.backgroundColor=self.getColorForiewFromInteger(viewInt)
            },
            completion:nil
        )
    }
    
    
    
    @IBAction func blueTouchDown(sender: AnyObject) {
        userPressAnimation(1)
    }
    @IBAction func blueTouchUpInside(sender: AnyObject) {
        userUnpressAnimation(1)
        verifieCorrectInput (1)
        
    }
    
    @IBAction func greenTouchBegan(sender: AnyObject) {
        userPressAnimation(3)
        
    }
    @IBAction func greenTouchEnded(sender: AnyObject) {
        userUnpressAnimation(3)
        verifieCorrectInput (3)
    }
    
    
    
    @IBAction func yellowTouchBegan(sender: AnyObject) {
        userPressAnimation(0)
        
    }
    
    @IBAction func yellowTouchEnded(sender: AnyObject) {
        userUnpressAnimation (0)
        verifieCorrectInput (0)
        
    }
    
    
    
    @IBAction func redTouchEnded(sender: AnyObject) {
        userUnpressAnimation (2)
        verifieCorrectInput (2)
    }
    
    @IBAction func redTouchBegan(sender: AnyObject) {
        userPressAnimation(2)
        
    }
    
    @IBAction func replayPressed(sender: AnyObject) {
        reinitGame()
        
        UIView.animateWithDuration(animationTime/2,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                self.gameOverView.alpha = 0
            },
            completion:{finished in self.startLevel()}
        )
    }
    
    @IBAction func okPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


