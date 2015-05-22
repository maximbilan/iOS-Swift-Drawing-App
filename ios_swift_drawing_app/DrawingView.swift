//
//  DrawingView.swift
//  ios_swift_drawing_app
//
//  Created by Maxim Bilan on 4/29/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class DrawingLine {
	var start: CGPoint
	var end: CGPoint
	var color: UIColor
	var width: CGFloat
	
	init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor!, width _width: CGFloat) {
		start = _start
		end = _end
		color = _color
		width = _width
	}
}

class DrawingView: UIView {
	
	var lines: [DrawingLine] = []
	var currentLines: [DrawingLine] = []
	
	var lastPoint: CGPoint!
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	var bezierPath: UIBezierPath!
	
	private var preRenderImage: UIImage!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initBezierPath()
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		initBezierPath()
	}
	
	func initBezierPath() {
		bezierPath = UIBezierPath()
		bezierPath.lineWidth = lineWidth
	}
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		lastPoint = touch!.locationInView(self)
		
		currentLines.removeAll(keepCapacity: false)
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		
		var newPoint = touch!.locationInView(self)
		
		let line = DrawingLine(start: lastPoint, end: newPoint, color: drawColor, width: lineWidth)
//		lines.append(line)
//		currentLines.append(line)
//		lastPoint = newPoint
//		
//		let imageRect = self.frame
//		let imageSize = imageRect.size
//		
//		UIGraphicsBeginImageContext(imageSize)
////		if preRenderImage != nil {
////			preRenderImage.drawInRect(imageRect)
////		}
//		
//		let context = UIGraphicsGetCurrentContext()
//		for line in lines {
//			CGContextSetLineWidth(context, line.width)
//			CGContextSetLineCap(context, kCGLineCapRound)
//			CGContextMoveToPoint(context, line.start.x, line.start.y)
//			CGContextAddLineToPoint(context, line.end.x, line.end.y)
//			CGContextSetStrokeColorWithColor(context, line.color.CGColor)
//			CGContextStrokePath(context)
//		}
//		
//		preRenderImage = UIGraphicsGetImageFromCurrentImageContext()
//		UIGraphicsEndImageContext()
//		
//		setNeedsDisplay()
		
		bezierPath.moveToPoint(line.start)
		bezierPath.addLineToPoint(line.end)
		
		lastPoint = newPoint
		
		setNeedsDisplay()
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		
	}
	
	override func drawRect(rect: CGRect) {
//		var context = UIGraphicsGetCurrentContext()
//		CGContextBeginPath(context)
//		for line in lines {
//			CGContextSetLineWidth(context, line.width)
//			CGContextSetLineCap(context, kCGLineCapRound)
//			CGContextMoveToPoint(context, line.start.x, line.start.y)
//			CGContextAddLineToPoint(context, line.end.x, line.end.y)
//			CGContextSetStrokeColorWithColor(context, line.color.CGColor)
//			CGContextStrokePath(context)
//		}
//		if preRenderImage != nil {
//			preRenderImage.drawInRect(rect)
//		}
		super.drawRect(rect)
		
		bezierPath.stroke()
	}

	func clear() {
		lines.removeAll(keepCapacity: false)
		setNeedsDisplay()
	}

	func hasLines() -> Bool {
		return lines.count > 0
	}

}
