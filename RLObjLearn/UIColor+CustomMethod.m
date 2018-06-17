//
//  UIColor+CustomMethod.m
//  RLObjLearn
//
//  Created by BitMad on 16/6/18.
//  Copyright © 2018 Rock Lee. All rights reserved.
//

#import "UIColor+CustomMethod.h"

@implementation UIColor (CustomMethod)

+ (UIColor *)randomColor
{
    CGFloat r = arc4random() % 100 /100.0;
    CGFloat g = arc4random() % 100 /100.0;
    CGFloat b = arc4random() % 100 /100.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
