//
//  RLHyperViewController.m
//  RLObjLearn
//
//  Created by Rock Lee on 07/11/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLHyperViewController.h"
#import "RLHyperView.h"

@interface RLHyperViewController() <UIScrollViewDelegate>
@property (strong, nonatomic) UIColor *themeColor;
@property (strong, nonatomic) RLHyperView *hyperView;
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
    
    self.hyperView = [[RLHyperView alloc] initWithFrame:targetFrame];
    UIScrollView * zoomContainer = [[UIScrollView alloc] initWithFrame:targetFrame];
    zoomContainer.delegate = self;
    zoomContainer.contentSize = self.hyperView.frame.size;
    [zoomContainer addSubview:self.hyperView];
    zoomContainer.pagingEnabled = NO;
    zoomContainer.maximumZoomScale = 2;
    zoomContainer.minimumZoomScale = 1;
    self.view = zoomContainer;
}

- (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
    if (self.hyperView){
        ((RLHyperView *)self.hyperView).themeColor = themeColor;
    }
}
- (void)demonstrateThemeColor:(UIColor *)color{
    self.themeColor = color;
    [self.view setNeedsDisplay];
    for (UIView * subView in self.view.subviews){
        [subView setNeedsDisplay];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.hyperView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    scrollView.zoomScale = MAX(1.0,scale);
}

@end


