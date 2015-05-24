//
//  EasyTetrisViewController.swift
//  EasyTetris
//
//  Created by Schor on 5/6/15.
//  Copyright (c) 2015 AandA Development. All rights reserved.
//

import UIKit

class EasyTetrisViewController: UIViewController {
    
    

    @IBOutlet var gameView: UIView!
    let dropBehavior = DropBehavior()
    lazy var animator : UIDynamicAnimator = {
            let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
            return lazilyCreatedDynamicAnimator
        }()
    
        @IBAction func tapGesture(sender: UITapGestureRecognizer) {
            drop(Int(sender.locationInView(gameView).x))
    }
    
    var dropsPerRow = 10
    var dropSize : CGSize {
    let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
    return CGSize(width: size, height: size)
    }
    
    func drop(x: Int) {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        //frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        frame.origin.x = CGFloat(x)
        let dropView = UIView(frame: frame)
        
        dropView.backgroundColor = UIColor.random
        
        gameView.addSubview(dropView)
        dropBehavior.addDrop(dropView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropBehavior)
    }
    
    @IBAction func switchAllowRotation(sender: UISwitch) {
        (dropBehavior.childBehaviors[2] as! UIDynamicItemBehavior).allowsRotation = sender.on
    }
    
    @IBAction func sliderBlocksPerRow(sender: UISlider) {
        dropsPerRow = Int(sender.value)
    }
    @IBAction func clearView(sender: UIButton) {
        for view in gameView.subviews{
            dropBehavior.removeDrop(view as! UIView)
            view.removeFromSuperview()
        }
    }
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random :UIColor {
        switch arc4random() % 7 {
        case 0: return UIColor.redColor()
        case 1: return UIColor.orangeColor()
        case 2: return UIColor.yellowColor()
        case 3: return UIColor.greenColor()
        case 4: return UIColor.blueColor()
        case 5: return UIColor.purpleColor()
        case 6: return UIColor.magentaColor()
        default: return UIColor.blackColor()
        }
    }
}