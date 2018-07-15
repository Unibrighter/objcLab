//
//  RLHyperViewController.m
//  RLObjLearn
//
//  Created by Rock Lee on 07/11/2017.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLHyperViewController.h"
#import "RLHyperView.h"

@interface RLHyperViewController() <UIScrollViewDelegate, UITextFieldDelegate>
#define INPUT_TEXT_FIELD_WIDTH 180
#define INPUT_TEXT_FIELD_HEIGHT 60
#define LABEL_COUNT 10
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
    
    //input text field
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0,0,INPUT_TEXT_FIELD_WIDTH,INPUT_TEXT_FIELD_HEIGHT)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.placeholder = @"WTFWTF!!!";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.center = CGPointMake(self.view.center.x, CGRectGetHeight(targetFrame) *0.1);
    [self.view addSubview:textField];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    __weak typeof (self) weakSelf = self;
    textField.delegate = weakSelf;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    
    for (NSUInteger i=0; i<LABEL_COUNT; i++){
        UILabel *labelWithRandomPosition = [[UILabel alloc] init];
        labelWithRandomPosition.text = textField.text;
        [labelWithRandomPosition sizeToFit];
        CGRect frame = labelWithRandomPosition.frame;
        frame.origin = [self randomRectWithinArea:self.view.bounds withSize:labelWithRandomPosition.frame.size];
        labelWithRandomPosition.frame = frame;
        [labelWithRandomPosition addMotionEffect:horizontalEffect];
        [labelWithRandomPosition addMotionEffect:verticalEffect];
        [self.view addSubview:labelWithRandomPosition];
    }
    
}

- (CGPoint)randomRectWithinArea:(CGRect)restrictedArea withSize:(CGSize)size{
    NSInteger x = arc4random()% (int)(restrictedArea.size.width-size.width)+restrictedArea.origin.x;
    NSInteger y = arc4random()% (int)(restrictedArea.size.height-size.height)+restrictedArea.origin.y;
    return CGPointMake(x, y);
}

@end


