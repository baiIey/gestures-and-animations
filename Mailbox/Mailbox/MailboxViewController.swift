//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Brian Bailey on 2/17/15.
//  Copyright (c) 2015 nevver. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {

    // scroll view contains feed, search, and get me to zero images
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImageView: UIImageView!
    
    // store original position of the message Facebook:Ka-Yen Aug 15...
    var messageOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // call combined size for vertical scrolling for the feed, search, and get me to zero images
        scrollView.contentSize = CGSize(width: 320, height: 1366)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action for horzontal panning of the Ka-Yen Aug 15 message
    @IBAction func messagePanGesture(sender: UIPanGestureRecognizer) {
        // store how far we've panned
        var translation = sender.translationInView(view)
        var location = sender.locationInView(view)

        if(sender.state == UIGestureRecognizerState.Began){
            // started to pan
            messageOrigin = messageImageView.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            messageImageView.center = CGPoint(x: messageOrigin.x + translation.x, y: messageImageView.center.y)
        } else if (sender.state == UIGestureRecognizerState.Ended){
            // ended pan
            println("Pan ended")
            messageImageView.center = messageOrigin
        }
    }
    
//    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
//        var point = panGestureRecognizer.locationInView(view)
//        var velocity = panGestureRecognizer.velocityInView(view)
//        
//        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
//            println("Gesture began at: \(point)")
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
//            println("Gesture changed at: \(point)")
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
//            println("Gesture ended at: \(point)")
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
