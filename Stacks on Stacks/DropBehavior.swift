//
//  DropBehavior.swift
//  EasyTetris
//
//  Created by Schor on 5/6/15.
//  Copyright (c) 2015 AandA Development. All rights reserved.
//

import UIKit

class DropBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
        }()
    
    lazy var dropModifiers : UIDynamicItemBehavior = {
        let lazilyCreatedDropModifiers = UIDynamicItemBehavior()
        lazilyCreatedDropModifiers.elasticity = 0.5
        lazilyCreatedDropModifiers.allowsRotation = false
        return lazilyCreatedDropModifiers
        }()

    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropModifiers)
    }
    
    func addDrop(drop: UIView) {
        gravity.addItem(drop)
        collider.addItem(drop)
        dropModifiers.addItem(drop)
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropModifiers.removeItem(drop)
    }
}
