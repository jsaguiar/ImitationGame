//
//  GameViewController.swift
//  Game
//
//  Created by Joao Aguiar on 24/03/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit

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
    
    var playingArray:[Int]=[0, 1, 3, 2, 1]
    var animatingPress:Int=0
    var numberOfPlayerPress:Int=0
    var showingAnimtation:Bool=false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centerView.layer.cornerRadius = 50
        self.centerView.layer.masksToBounds = true
     
        self.centerLabel.text = "1"
    }

    
    func imageFromColor(color:UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
        CGContextFillRect(context, rect);
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
    
 
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startLevel()

    }
    
    func startLevel(){
        numberOfPlayerPress=0
        var a:Int = Int(arc4random()) % 4
        playingArray.append(a)
        self.centerLabel.text = "\(playingArray.count)"
        
        animatingPress=0
        showingAnimtation = true
        animatePress(self.playingArray[animatingPress])
        println(playingArray)
    }
    
    func animatePress(viewInt:Int){
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
        println("gaameOver")
    }
    
    func nextRound(){
        println("nextRound")
        startLevel()
    }
    
    func verifieCorrectInput(input:Int){
        
        if showingAnimtation || numberOfPlayerPress >= self.playingArray.count{
            return
        }
        if self.playingArray[numberOfPlayerPress] != input {
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
            options: .CurveEaseInOut,
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
            options: .CurveEaseInOut,
            animations: {
                let view = self.getViewFromInteger(viewInt)
                view.backgroundColor=self.getColorForiewFromInteger(viewInt)
            },
            completion:nil)
    }

    
    
    @IBAction func blueTouchDown(sender: AnyObject) {
        userPressAnimation(1)
    }
    @IBAction func blueTouchUpInside(sender: AnyObject) {
        userUnpressAnimation(1)
        verifieCorrectInput (1)

    }
    
    @IBAction func greenTouchBegan(sender: AnyObject) {
        userPressAnimation(2)

    }
    @IBAction func greenTouchEnded(sender: AnyObject) {
        userUnpressAnimation(3)
        verifieCorrectInput (3)
    }
    
    
    
    @IBAction func yellowTouchBegan(sender: AnyObject) {
        userPressAnimation(0)

    }
    
    @IBAction func yellowTouchEnded(sender: AnyObject) {
        userUnpressAnimation(10)
        verifieCorrectInput (0)

    }

    
    
    @IBAction func redTouchEnded(sender: AnyObject) {
        userUnpressAnimation(2)
        verifieCorrectInput (2)
    }

    @IBAction func redTouchBegan(sender: AnyObject) {
        userPressAnimation(2)

    }
    
    
}


