//
//  InitialViewController.m
//  drawer
//
//  Created by Mayank on 04/06/15.
//  Copyright (c) 2015 Mayank. All rights reserved.
//

#import "InitialViewController.h"

#import "DrawerViewController.h"

@interface InitialViewController ()
{
    DrawerViewController *drawerViewController;
}
@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!drawerViewController)
    {
        drawerViewController = ((DrawerViewController *)[self.storyboard  instantiateViewControllerWithIdentifier:@"DrawerViewController"]);
        drawerViewController.containerViewController = self;
        
        drawerViewController.view.frame = self.view.frame;
        drawerViewController.view.center = CGPointMake(drawerViewController.view.center.x, 2 * self.view.center.y + drawerViewController.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
        
        [self.view addSubview:drawerViewController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
