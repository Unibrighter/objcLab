//
//  RLHyperViewController.m
//  RLObjLearn
//
//  Created by Rock Lee on 07/11/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLHyperViewController.h"
#import "RLHyperView.h"

@interface RLHyperViewController()
@property (strong, nonatomic) UIColor *themeColor;
@end

@implementation RLHyperViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(nil!=self){
        self.tabBarItem.title = @"Hyper View";
        self.tabBarItem.image = [UIImage imageNamed:@"rotate"];
        
    }
    return self;
}



-(void)loadView{
    CGRect targetFrame = [UIScreen mainScreen].bounds;
    RLHyperView * backgroundView = [[RLHyperView alloc]initWithFrame:targetFrame];
    
    self.view = backgroundView;
}

- (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
    if (self.view && [self.view isKindOfClass:[RLHyperView class]]){
        
        ((RLHyperView *)self.view).themeColor = themeColor;
    }
}
- (void)demonstrateThemeColor:(UIColor *)color{
    self.themeColor = color;
    [self.view setNeedsDisplay];
}

@end


