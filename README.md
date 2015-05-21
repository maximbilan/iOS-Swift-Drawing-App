<h4>iOS Swift Drawing Application Sample</h4>

Simple example which describes how to draw in the <i>UIView</i> using <i>Swift</i> programming language.

![alt tag](https://raw.github.com/maximbilan/ios_swift_drawing_app/master/img/img1.png)

We have two classes: <i>DrawingLine</i> and <i>DrawingView</i>. The first for storing data and the second for drawing.
<i>DrawingLine</i>:

<pre>
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
</pre>

We need to store start point, last point, color and line width.
And <i>DrawingView</i> class inherited from <i>UIView</i>.

<pre>
class DrawingView: UIView {
	var lines: [DrawingLine] = []
	var lastPoint: CGPoint!
	var drawColor = UIColor.blackColor()
	var lineWidth: CGFloat = 5
	
	...
</pre>

An array of lines, last point color and line width. That's all.
In touch handling methods we need implement the next:

<pre>
override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
	lastPoint = touch!.locationInView(self)
}
	
override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
		
	var newPoint = touch!.locationInView(self)
	lines.append(DrawingLine(start: lastPoint, end: newPoint, color: drawColor, width: lineWidth))
	lastPoint = newPoint
		
	setNeedsDisplay()
}
</pre>

In the touches began method we write position to last point variable.
In the touches moved we store point to array and change the last point. And redraw view.

And render method:

<pre>
override func drawRect(rect: CGRect) {
	var context = UIGraphicsGetCurrentContext()
	CGContextBeginPath(context)
	for line in lines {
		CGContextSetLineWidth(context, line.width)
		CGContextSetLineCap(context, kCGLineCapRound)
		CGContextMoveToPoint(context, line.start.x, line.start.y)
		CGContextAddLineToPoint(context, line.end.x, line.end.y)
		CGContextSetStrokeColorWithColor(context, line.color.CGColor)
		CGContextStrokePath(context)
	}
}
</pre>

Drawing of stored points.<br>
For clearing the view we need remove all lines and update the display:
<pre>
func clear() {
	lines.removeAll(keepCapacity: false)
	setNeedsDisplay()
}
</pre>

And for checking lines on the view:
<pre>
func hasLines() -> Bool {
	return lines.count > 0
}
</pre>

That's all and we have really simple drawing application written by <i>Swift</i>.
<br>
To do:
- Improve performance
