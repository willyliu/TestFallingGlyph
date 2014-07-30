//
//  GameViewController.swift
//  TestFallingGlyph
//
//  Created by Willy Liu on 2014/7/29.
//  Copyright (c) 2014年 Willy Liu. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()

		let skView = self.view as SKView
				
		/* Sprite Kit applies additional optimizations to improve rendering performance */
		skView.ignoresSiblingOrder = true
		
		/* Set the scale mode to scale to fit the window */
		scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFill
		
		skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
		return Int(UIInterfaceOrientationMask.Portrait.toRaw())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
