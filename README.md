<h4>iOS Swift Drawing Application Sample</h4>

Simple example which describes how to draw in the UIView using Swift programming language.

![alt tag](https://raw.github.com/maximbilan/ios_swift_drawing_app/master/img/img1.png)

We've two classes: DrawingLine and DrawingView. The first for storing data and the second for drawing.
DrawingLine:

<pre>
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
</pre>

We need to store start point, last point and color.
And DrawingView class inherited from UIView.

<pre>
class DrawingView: UIView {
	var lines: [DrawingLine] = []
	var lastPoint: CGPoint!
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	...
</pre>

An array of lines, last point, color and line width. That's all.
In touch handling methods we need implement the next:

<pre>
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
</pre>

In the touches began method we write position to last point variable.
In the touches moved we store point to array and change the last point. And redraw view.

And render method:

<pre>
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
</pre>

Drawing of stored points.
That's all and we have really simple drawing application written by Swift.
