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
    @IBOutlet weak var backgroundColor: UIView!
    @IBOutlet weak var feedView: UIImageView!
    
    // message icons
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    // overlays
    @IBOutlet weak var listOverlay: UIImageView!
    @IBOutlet weak var rescheduleOverlay: UIImageView!
    
    // store original position of the message Facebook:Ka-Yen Aug 15...
    var messageOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Figures my background color would be controlled by a property called background color...
        backgroundColor.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        listOverlay.alpha = 0
        rescheduleOverlay.alpha = 0

        // Do any additional setup after loading the view.
        
        // call combined size for vertical scrolling for the feed, search, and get me to zero images
        scrollView.contentSize = CGSize(width: 320, height: 1368)
        
        // set alpha to zero for all images
        self.archiveIcon.alpha = 0
        self.deleteIcon.alpha = 0
        self.laterIcon.alpha = 0
        self.listIcon.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // dimiss list or rechedule email overlay and animate feed over the dimissed message
    @IBAction func closeOverlayDidTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listOverlay.alpha = 0
            self.rescheduleOverlay.alpha = 0
            self.delay(0.2, closure: { () -> () in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.feedView.center.y = 675
                })
            })
        })
        
        println("Tap overlay")
    }
    
    // navigation controller
    @IBAction func segmentedController(sender: UISegmentedControl) {
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
            // allows for panning on the x-axis only
            messageImageView.center = CGPoint(x: messageOrigin.x + translation.x, y: messageImageView.center.y)
            
            // detect translation, movement on x axis in points, and adust background color
            
            if (translation.x == 0 ) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
            // pan left a little, turn green
            } else if (translation.x > 0 && translation.x < 60 ) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
                
            } else if (translation.x > 60 && translation.x < 260){
                //println("translation.x >60")
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 165/255, green: 214/255, blue: 167/255, alpha: 1.0)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })

            // pan left a lot, turn red
            } else if (translation.x > 260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 229/255, green: 115/255, blue: 115/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 1
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })

            // pan right a little, reveal icon while gray
            } else if (translation.x < 0 && translation.x > -60) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                })

            // pan right a little, turn yellow
            } else if (translation.x < -60 && translation.x > -260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 88/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                })

            // pan right a lot, turn brown
            } else if (translation.x < -260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 188/255, green: 170/255, blue: 164/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                })

            // otherwise, default to gray
            } else {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.backgroundColor.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
            }
          
            // println("messageOrgin + translation \(messageOrigin.x + translation.x)")
            println("translation on x-axis: \(translation.x)")
            
        } else if (sender.state == UIGestureRecognizerState.Ended){
            // ended pan
            // println("Pan ended")
            // animation to slowly snap the message back into its original position

            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.messageImageView.center = self.messageOrigin
            })

            if (translation.x > 0 && translation.x < 60 ) {
                
            } else if (translation.x > 60 && translation.x < 259){
                //println("translation.x >60")
                
                // Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.center.x = 640
                    self.delay(0.5, closure: { () -> () in
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedView.center.y = 675
                        })
                    })
                    
                })
                
                // pan left a lot, turn red
            } else if (translation.x > 260){
                // Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.center.x = 640
                    self.delay(0.5, closure: { () -> () in
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedView.center.y = 675
                        })
                    })
                    
                })
                // pan right a little, turn yellow
            } else if (translation.x < 0 && translation.x > -59) {
                
                // pan right a lot, yellow
                // message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
            } else if (translation.x < -60 && translation.x > -260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.center.x = -160
//                    self.delay(0.5, closure: { () -> () in
//                        UIView.animateWithDuration(0.5, animations: { () -> Void in
//                            self.feedView.center.y = 675
//                        })
//                    })
                    self.delay(0.5, closure: { () -> () in
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.rescheduleOverlay.alpha = 1.0
                        })
                    })
                })
                
                // pan right a lot, turn brown
            } else if (translation.x < -260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.center.x = -160
//                    self.delay(0.5, closure: { () -> () in
//                        UIView.animateWithDuration(0.5, animations: { () -> Void in
//                            self.feedView.center.y = 675
//                        })
//                    })
                    self.delay(0.5, closure: { () -> () in
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.listOverlay.alpha = 1.0
                        })
                    })
                })
                
                // otherwise, default to gray
            } else {
            }

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
