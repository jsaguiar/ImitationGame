//
//  GameViewController.swift
//  Game
//
//  Created by Joao Aguiar on 24/03/2015.
//  Copyright (c) 2015 Joao Aguiar. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    let defaultBtnColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    let blueBtnColor = UIColor(red: 0.0, green: 0.0, blue: 0.4, alpha: 1)
    let redBtnColor = UIColor(red: 0.4, green: 0.0, blue: 0.0, alpha: 1)
    let greenBtnColor = UIColor(red: 0.0, green: 0.4, blue: 0.0, alpha: 1)
    let yellowBtnColor = UIColor(red: 0, green: 0.4, blue: 0.4, alpha: 1)
    
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var centerLabel: UILabel!
    
    var level:Int?
    var playingArray:[Int]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deaultImage = imageFromColor(defaultBtnColor)
        
        self.blueBtn.setBackgroundImage(deaultImage, forState: UIControlState.Normal)
        self.redBtn.setBackgroundImage(deaultImage, forState: UIControlState.Normal)
        self.greenBtn.setBackgroundImage(deaultImage, forState: UIControlState.Normal)
        self.yellowBtn.setBackgroundImage(deaultImage, forState: UIControlState.Normal)
        
        self.blueBtn.setBackgroundImage(imageFromColor(blueBtnColor), forState: UIControlState.Highlighted)
        self.redBtn.setBackgroundImage(imageFromColor(redBtnColor), forState: UIControlState.Highlighted)
        self.greenBtn.setBackgroundImage(imageFromColor(greenBtnColor), forState: UIControlState.Highlighted)
        self.yellowBtn.setBackgroundImage(imageFromColor(yellowBtnColor), forState: UIControlState.Highlighted)

        self.centerView.layer.cornerRadius = 50
        self.centerView.layer.masksToBounds = true
        
        level=1
        self.centerLabel.text = "\(level!)"
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
    func getLevel(){
        var a:Int = random()%4
        playingArray.append(a)
    }
    
    func startPlay(){
        getLevel()
        for i in self.playingArray {
            
        }
        
    }
    
   
}


