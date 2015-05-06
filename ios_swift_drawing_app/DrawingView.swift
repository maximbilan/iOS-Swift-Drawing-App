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
	
	init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor!) {
		start = _start
		end = _end
		color = _color
	}
}

class DrawingView: UIView {

	var lines: [DrawingLine] = []
	var lastPoint: CGPoint!
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		lastPoint = touch!.locationInView(self)
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		
		var newPoint = touch!.locationInView(self)
		lines.append(DrawingLine(start: lastPoint, end: newPoint, color: drawColor))
		lastPoint = newPoint
		
		self.setNeedsDisplay()
	}
	
	override func drawRect(rect: CGRect) {
		var context = UIGraphicsGetCurrentContext()
		CGContextBeginPath(context)
		CGContextSetLineWidth(context, lineWidth)
		CGContextSetLineCap(context, kCGLineCapRound)
		for line in lines {
			CGContextMoveToPoint(context, line.start.x, line.start.y)
			CGContextAddLineToPoint(context, line.end.x, line.end.y)
			CGContextSetStrokeColorWithColor(context, line.color.CGColor)
			CGContextStrokePath(context)
		}
	}

}
