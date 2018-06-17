//
//  RLTabBarController.m
//  RLObjLearn
//
//  Created by BitMad on 20/11/17.
//  Copyright © 2017 Rock Lee. All rights reserved.
//

#import "RLTabBarController.h"

@interface RLTabBarController ()

@property NSUInteger fromIndex;
@property NSUInteger toIndex;
@property (weak) UIView *fromView;

@end

@implementation RLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self expandSubTabViewFrame];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)expandSubTabViewFrame{
    for(UIViewController * tabVC in self.viewControllers){
        tabVC.view.frame = [UIScreen  mainScreen].bounds;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self expandSubTabViewFrame];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIView *fromView = tabBarController.selectedViewController.view;
    UIView *toView = viewController.view;
    
    if (!fromView || !toView){
        return NO;
    }
    else{
        self.fromIndex = self.selectedIndex;
        self.fromView = fromView;
        return YES;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.toIndex = self.selectedIndex;
    UIView *toView = viewController.view;
    if (self.fromIndex < self.toIndex){
        self.fromView.frame = toView.frame;
        [self.view addSubview:self.fromView];
        [self.view bringSubviewToFront:self.tabBar];
        toView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toView.frame), 0);
        [UIView animateWithDuration:0.3 animations:^{
            self.fromView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.fromView.frame), 0);
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
//            if (finished){
//                [self.fromView removeFromSuperview];
//            }
        }];
    }else if (self.fromIndex > self.toIndex){
        self.fromView.frame = toView.frame;
        [self.view addSubview:self.fromView];
        [self.view bringSubviewToFront:self.tabBar];
        toView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(toView.frame), 0);
        [UIView animateWithDuration:0.3 animations:^{
            self.fromView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.fromView.frame), 0);
            toView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
//            if (finished){
//                [self.fromView removeFromSuperview];
//            }
        }];
    }else{
        NSLog(@"The same view controller picked. No animatino is needed.");
    }
}

@end
