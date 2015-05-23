<h4>iOS Swift Drawing Application Sample</h4>

Simple example which describes how to draw in the <i>UIView</i> using <i>Swift</i> programming language.

![alt tag](https://raw.github.com/maximbilan/ios_swift_drawing_app/master/img/img1.png)

We need to create the class DrawingView inherited from UIView. With the next properties:
<pre>
var drawColor = UIColor.blackColor()	// Color for drawing
var lineWidth: CGFloat = 5				// Line width
	
private var lastPoint: CGPoint!			// Point for storing the last position
private var bezierPath: UIBezierPath!	// Bezier path
private var pointCounter: Int = 0		// Counter of ponts
private let pointLimit: Int = 128		// Limit of points
private var preRenderImage: UIImage!	// Pre render image
</pre>

First of all, initialization. We need to create UIBezierPath and setup some properties.

<pre>
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
	bezierPath.lineCapStyle = kCGLineCapRound
	bezierPath.lineJoinStyle = kCGLineJoinRound
}
</pre>

For better performance we will store bezier path rendering to UIImage, so, create the function renderToImage.
<pre>
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
</pre>

And implement the rendering function.
<pre>
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
</pre>

First, draw the pre render image and after that current bezier path.<br>
Noew, main of our application, it's touch handling.

In touchesBegan function we save last point and reset the point counter.

<pre>
override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
	lastPoint = touch!.locationInView(self)
	pointCounter = 0
}
</pre>

In touchesMoved function, add point to bezier path, increment point counter and if point counter equals point limit, than render bezier path to UIImage and reset bezier path. And of course update the screen.

<pre>
override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
	let touch: AnyObject? = touches.first
	var newPoint = touch!.locationInView(self)
		
	bezierPath.moveToPoint(lastPoint)
	bezierPath.addLineToPoint(newPoint)
	lastPoint = newPoint
		
	++pointCounter
		
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
</pre>

In touchesEnded function reset pointer counter, render bezier path to UIImage and reset bezier path and update the screen.

<pre>
override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
	pointCounter = 0
	renderToImage()
	setNeedsDisplay()
	bezierPath.removeAllPoints()
}
</pre>

In touchesCancelled function just call touchesEnded method.

<pre>
override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
	touchesEnded(touches, withEvent: event)
}
</pre>

For clearing the view we need remove all lines and update the display:

<pre>
preRenderImage = nil
bezierPath.removeAllPoints()
setNeedsDisplay()
</pre>

And for checking lines on the view:

<pre>
func hasLines() -> Bool {
		return preRenderImage != nil || !bezierPath.empty
	}
</pre>

That's all and we have really simple drawing application written by <i>Swift</i>.
