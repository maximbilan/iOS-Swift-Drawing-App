//
//  DrawingView.swift
//  ios_swift_drawing_app
//
//  Created by Maxim Bilan on 4/29/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class DrawingView: UIView {
	
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	private var lastPoint: CGPoint!
	private var bezierPath: UIBezierPath!
	private var pointCounter: Int = 0
	private let pointLimit: Int = 128
	private var preRenderImage: UIImage!
	
	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initBezierPath()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		initBezierPath()
	}
	
	func initBezierPath() {
		bezierPath = UIBezierPath()
		bezierPath.lineCapStyle = CGLineCap.Round
		bezierPath.lineJoinStyle = CGLineJoin.Round
	}
	
	// MARK: - Touch handling
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touch: AnyObject? = touches.first
		lastPoint = touch!.locationInView(self)
		pointCounter = 0
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touch: AnyObject? = touches.first
		let newPoint = touch!.locationInView(self)
		
		bezierPath.moveToPoint(lastPoint)
		bezierPath.addLineToPoint(newPoint)
		lastPoint = newPoint
		
		pointCounter += 1
		
		if pointCounter == pointLimit {
			pointCounter = 0
			renderToImage()
			setNeedsDisplay()
			bezierPath.removeAllPoints()
		}
		else {
			setNeedsDisplay()
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		pointCounter = 0
		renderToImage()
		setNeedsDisplay()
		bezierPath.removeAllPoints()
	}
	
	override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		touchesEnded(touches!, withEvent: event)
	}
	
	// MARK: - Pre render
	
	func renderToImage() {
		
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
		if preRenderImage != nil {
			preRenderImage.drawInRect(self.bounds)
		}
		
		bezierPath.lineWidth = lineWidth
		drawColor.setFill()
		drawColor.setStroke()
		bezierPath.stroke()
		
		preRenderImage = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
	}
	
	// MARK: - Render
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		if preRenderImage != nil {
			preRenderImage.drawInRect(self.bounds)
		}
		
		bezierPath.lineWidth = lineWidth
		drawColor.setFill()
		drawColor.setStroke()
		bezierPath.stroke()
	}

	// MARK: - Clearing
	
	func clear() {
		preRenderImage = nil
		bezierPath.removeAllPoints()
		setNeedsDisplay()
	}
	
	// MARK: - Other

	func hasLines() -> Bool {
		return preRenderImage != nil || !bezierPath.empty
	}

}
