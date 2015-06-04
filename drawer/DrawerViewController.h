//
//  DrawerViewController.h
//  drawer
//
//  Created by Mayank on 27/05/15.
//  Copyright (c) 2015 Mayank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PANNING_VELOCITY 350
#define VSP_BUTTON_HEIGHT 55
#define VSP_TRANSITION_DURATION 0.2

@interface DrawerViewController : UIViewController

@property(nonatomic, weak) UIViewController *containerViewController;

@end

