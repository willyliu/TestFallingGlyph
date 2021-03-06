//
//  GameScene.swift
//  TestFallingGlyph
//
//  Created by Willy Liu on 2014/7/29.
//  Copyright (c) 2014年 Willy Liu. All rights reserved.
//

import SpriteKit
import CoreText

class GameScene: SKScene {
	let upperString = "太爽"
	let lowerString = "了"
	var upperGlyphs = [SKShapeNode]()
	var lowerGlyphs = [SKShapeNode]()
	var startX: CGFloat = 0.0
	var totalWidth: CGFloat = 0.0
	let upperStringY: CGFloat = 200.0
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
		scene.physicsWorld.speed = 0.1
		reset()
    }
	
	private func reset() {
		totalWidth = 0.0
		startX = 0.0
		removeAllChildren()
		
		upperGlyphs = getGlyphsFromString(upperString)
		layoutUpperGlyphs()
		lowerGlyphs = getGlyphsFromString(lowerString)
		layoutLowerGlyphs()
		addAllGlyphs()
		addBar()
	}
	
	private func addBar() {
		let bar = SKShapeNode(rectOfSize: CGSizeMake(totalWidth, 5.0))
		bar.fillColor = SKColor.grayColor()
		bar.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(totalWidth, 5.0))
		bar.position = CGPointMake(startX + totalWidth / 2, upperStringY - 20.0)
		bar.name = "bar"
		addChild(bar)
	}
	
	private func addAllGlyphs() {
		for node in upperGlyphs {
			addChild(node)
		}
		for node in lowerGlyphs {
			addChild(node)
		}
	}
	
	private func layoutUpperGlyphs() {
		for node in upperGlyphs {
			totalWidth += node.frame.width
		}
		startX = (frame.width - totalWidth) / 2
		var x = startX
		let y:CGFloat = upperStringY
		for node in upperGlyphs {
			node.position = CGPoint(x: x, y: y)
			x += node.frame.width
		}
	}
	
	private func layoutLowerGlyphs() {
		var totalLowerWidth:CGFloat = 0.0
		for node in lowerGlyphs {
			totalLowerWidth += node.frame.width
		}
		var x:CGFloat = (frame.width - totalLowerWidth) / 2
		let y:CGFloat = upperStringY - 80.0
		for node in lowerGlyphs {
			node.position = CGPoint(x: x, y: y)
			x += node.frame.width
		}
	}
	
	private func getGlyphsFromString(string:String) -> [SKShapeNode] {
		let paths = getCGPathsForString(string)
		var result = [SKShapeNode]()
		for path in paths {
			let node = getShapeNodeFromCGPath(path)
			result.append(node)
		}
		return result
	}
	
	private func getShapeNodeFromCGPath(path: CGPath) -> SKShapeNode {
		let node = SKShapeNode()
		node.path = path
		node.fillColor = SKColor.grayColor()
		node.physicsBody = SKPhysicsBody(polygonFromPath: path)
		return node
	}
	
	private func getCGPathsForString(string: String) -> [CGPath] {
		let myFont = CTFontCreateWithName("HiraKakuProN-W6", 72, nil)
		var chars = [unichar]()
		let length = (string as NSString).length
		for i in Range(start: 0, end: length) {
			chars.append((string as NSString).characterAtIndex(i))
		}
		var glyphs = [CGGlyph](count: length, repeatedValue: 0)
		let getGlyphsResult = CTFontGetGlyphsForCharacters(myFont, chars, UnsafePointer<CGGlyph>(glyphs), length)
		var myTransform = CGAffineTransformIdentity

		var paths = [CGPath]()
		for i in Range(start: 0, end: length) {
			var path = withUnsafePointer(&myTransform) { (pointer: UnsafePointer<CGAffineTransform>) -> (CGPath) in
				return CTFontCreatePathForGlyph(myFont, glyphs[i], pointer)
			}
			paths.append(path)
		}
		return paths
	}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
		reset()
	}
}
