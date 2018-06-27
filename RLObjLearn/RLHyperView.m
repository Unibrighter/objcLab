//
//  RLHyperView.m
//  RLObjLearn
//
//  Created by Rock Lee on 21/10/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLHyperView.h"
#import "UIColor+CustomMethod.h"

@interface RLHyperView ()

@property (readonly) CGFloat boundingBoxHeight;
@property (readonly) CGFloat boundingBoxWidth;

@property CGGradientRef gradient;
@end

@implementation RLHyperView

- (void)drawRect:(CGRect)rect {
	_boundingBoxWidth = rect.size.width;
	_boundingBoxHeight = rect.size.height;
	
	UIColor * targetColor = [UIColor colorWithRed:215/256.0 green:171/256.0 blue:74/256.0 alpha:1.0];
	
	//1.Inner Circle - Apple in the eye
	CGPoint centerPoint = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    NSLog(@"%@", NSStringFromCGRect(self.frame));
	
    [targetColor setStroke];
	for(CGFloat radius = _boundingBoxHeight;radius >= _boundingBoxWidth/10;radius -= _boundingBoxHeight /10 ){
        UIBezierPath * innerPie = [[UIBezierPath alloc] init];
        innerPie.lineWidth = 5.0;
		[innerPie moveToPoint:CGPointMake(centerPoint.x-radius,centerPoint.y)];
		[innerPie addArcWithCenter:centerPoint radius:radius startAngle: -M_PI endAngle:M_PI clockwise:YES];
        [innerPie closePath];
        if (self.themeColor){
            [self.themeColor setFill];
        }else{
            UIColor *randomColor = [UIColor randomColor];
            [randomColor setFill];
        }
        [innerPie fill];
        [innerPie stroke];
	}
    //reset the theme color
    self.themeColor = nil;
    
	
	//2. gradiant
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	UIBezierPath * gradientPath = [UIBezierPath new];
	[gradientPath moveToPoint:CGPointMake(0.5*rect.size.width , 0.333*rect.size.height)];
	[gradientPath addLineToPoint:CGPointMake(0.25*rect.size.width , 0.667*rect.size.height)];
	[gradientPath addLineToPoint:CGPointMake(0.75*rect.size.width , 0.667*rect.size.height)];
    [gradientPath closePath];
	[gradientPath addClip];
	if(!_gradient){
		_gradient = [self getRandomGradientRef];
	}
	CGContextDrawLinearGradient(currentContext, _gradient, CGPointMake(0.5*rect.size.width , 0.333*rect.size.height), CGPointMake(0.25*rect.size.width , 0.667*rect.size.height), 0);
	CGContextRestoreGState(currentContext);
	
	//3. image and shadow
	UIImage * vaultBoy = [UIImage imageNamed:@"VaultBoy"];
	CGFloat scaleRatio = 0.5*rect.size.width/vaultBoy.size.width;
	UIImage * scaledImage = [UIImage imageWithCGImage:vaultBoy.CGImage scale:1.0/scaleRatio orientation:UIImageOrientationUp];
	
	CGRect targetRect = CGRectMake(0.5*(rect.size.width - scaledImage.size.width),
								   0.5*(rect.size.height - scaledImage.size.height),
								   scaledImage.size.width, scaledImage.size.height);

	CGContextSaveGState(currentContext);
	CGContextSetShadow(currentContext, CGSizeMake(5, 5), 3);
	[scaledImage drawInRect:targetRect];
	CGContextRestoreGState(currentContext);
	
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"View touched!");
    _gradient = [self getRandomGradientRef];
    [self setNeedsDisplay];
}

-(CGGradientRef)getRandomGradientRef{
	CGFloat location[2] = {0,1};
	CGFloat r1 = (arc4random() % 100) /100.0;
	CGFloat g1 = (arc4random() % 100) /100.0;
	CGFloat b1 = (arc4random() % 100) /100.0;
	
	CGFloat r2 = (arc4random() % 100) /100.0;
	CGFloat g2 = (arc4random() % 100) /100.0;
	CGFloat b2 = (arc4random() % 100) /100.0;	
	CGFloat components [8] = {r1,g1,b1,1,r2,g2,b2,1};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components , location, 2);
	return gradient;
}



@end
