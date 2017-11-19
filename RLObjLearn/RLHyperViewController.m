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

@end



@implementation RLHyperViewController

-(void)loadView{
    CGRect targetFrame = [UIScreen mainScreen].bounds;
    RLHyperView * backgroundView = [[RLHyperView alloc]initWithFrame:targetFrame];
    
    self.view = backgroundView;
}

@end


