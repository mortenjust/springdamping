//
//  ViewController.swift
//  springanddamping
//
//  Created by Morten Just Petersen on 3/13/15.
//  Copyright (c) 2015 Morten Just Petersen. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var dampingSlider: UISlider!
    var springSlider: UISlider!
    var animateBall: UIView!
    var durationSlider: UISlider!
    var animateButton: UIButton!
    var trackMargin:CGFloat = 100
    var trackView : UIView!
    var label: UILabel!
    
    var spring: Float = 0.5
    var damping: Float = 0.5
    var duration: Float = 1.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func setup(){
        trackView = UIView(frame: CGRectMake(self.view.bounds.minX + self.trackMargin, self.view.center.y, self.view.bounds.width-(trackMargin*2), 2))
        trackView.backgroundColor = UIColor.lightGrayColor()
        trackView.alpha = 0.3
        self.view.addSubview(trackView)
        
        springSlider = UISlider(frame: CGRectMake(0, 0, self.view.bounds.width, 50))
        dampingSlider = UISlider(frame: springSlider.bounds)
        durationSlider = UISlider(frame: dampingSlider.bounds)
        
        durationSlider.maximumValue = 3
        durationSlider.minimumValue = 0
        
        dampingSlider.center.y = 50
        springSlider.center.y = dampingSlider.center.y + 40
        durationSlider.center.y = springSlider.center.y + 40
        
        springSlider.addTarget(self, action: "springChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        dampingSlider.addTarget(self, action: "dampingChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        durationSlider.addTarget(self, action: "durationChanged:", forControlEvents: UIControlEvents.TouchUpInside)
        
        springSlider.setValue(spring, animated: true)
        dampingSlider.setValue(damping, animated: true)
        durationSlider.setValue(duration, animated: true)
        
        self.view.addSubview(dampingSlider)
        self.view.addSubview(springSlider)
        self.view.addSubview(durationSlider)
        
        animateBall = UIView(frame: CGRectMake(0, 0, 30, 30))
        animateBall.clipsToBounds = true
        animateBall.layer.cornerRadius = animateBall.bounds.height/2
        animateBall.backgroundColor = UIColor.redColor()
        animateBall.center = CGPointMake(0, self.view.bounds.midY)
        self.view.addSubview(animateBall)
        
        animateButton = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width-20, 50))
        animateButton.center.y = self.view.center.y + 300
        animateButton.center.x = self.view.center.x
        animateButton.backgroundColor = UIColor.blueColor()
        animateButton.setTitle("Play again", forState: UIControlState.Normal)
        animateButton.addTarget(self, action: "animatePressed", forControlEvents: UIControlEvents.TouchUpInside)
 
        self.view.addSubview(animateButton)
        
        label = UILabel(frame: CGRectMake(self.view.center.x, self.view.center.y-100, self.view.bounds.width, 100))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Avenir-Medium", size: 13)
        label.center.x = self.view.center.x
        
        self.view.addSubview(label)
        

        self.restartAnimation(CGFloat(self.spring), damping: CGFloat(self.damping), duration: CGFloat(self.duration))

    }
    
    func animatePressed(){
        println("animate pressed")
//        animateBall.layer.removeAllAnimations()


        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            //none
        }) { (what) -> Void in
            self.restartAnimation(CGFloat(self.spring), damping: CGFloat(self.damping), duration: CGFloat(self.duration))
        }
        
    }
    
    func durationChanged(slider:UISlider){
        duration = slider.value
        restartAnimation(CGFloat(spring), damping: CGFloat(damping), duration:CGFloat(duration))
    }
    
    func springChanged(slider:UISlider){
        println("chan")
        println(slider.value)
        spring = slider.value
         animateBall.layer.removeAllAnimations()
        restartAnimation(CGFloat(spring), damping: CGFloat(damping), duration:CGFloat(duration))
    }
    
    func dampingChanged(slider: UISlider){
        println(slider.value)
        damping = slider.value
         animateBall.layer.removeAllAnimations()
        restartAnimation(CGFloat(spring), damping: CGFloat(damping), duration:CGFloat(duration))
    }

    
    func restartAnimation(spring:CGFloat, damping:CGFloat, duration _d: CGFloat) {
        
        var springR = Float(round(100*spring)/100)
        var dampingR = Float(round(100*damping)/100)
        var durationR = Float(round(100*duration)/100)
        
        label.text = "Spring: \(springR), Damping: \(dampingR), Duration: \(durationR)"
        
        var _du = NSTimeInterval(_d)
        
        self.animateBall.center.x = self.view.bounds.minX + trackMargin
        
        UIView.animateWithDuration(_du, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: spring, options: nil, animations: { () -> Void in
            
            self.animateBall.center.x = self.view.bounds.maxX - self.trackMargin
            
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

