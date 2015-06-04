//
//  DrawerViewController.m
//  drawer
//
//  Created by Mayank on 27/05/15.
//  Copyright (c) 2015 InfoEdge Pvt. Ltd. All rights reserved.
//

#import "DrawerViewController.h"


@interface DrawerViewController()
{
    BOOL isSimilarPropertyViewVisible;
}

@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIImageView *disclosureImageView;
@property (weak, nonatomic) IBOutlet UILabel *similarTitleLabel;

@end

@implementation DrawerViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    isSimilarPropertyViewVisible = NO;
}

- (IBAction)handlePanningForView:(UIPanGestureRecognizer *)recognizer
{
    self.view.userInteractionEnabled = NO;
    self.view.superview.userInteractionEnabled = NO;
    
    CGPoint translation = [recognizer translationInView:self.view.superview];
    if (recognizer.view)
    {
        int currentCenterCoordinate = self.view.center.y + translation.y;
        if (currentCenterCoordinate <= self.view.superview.center.y + VSP_BUTTON_HEIGHT)
        {
            self.view.center = CGPointMake(self.view.center.x, self.view.superview.center.y + VSP_BUTTON_HEIGHT);
            [self openSimilarProperties:YES];
            
            return;
        }
        
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGPoint gestureVelocity = [recognizer velocityInView: self.view.superview];
            if (currentCenterCoordinate <= 2 * self.view.superview.center.y)
            {
                if (gestureVelocity.y >= PANNING_VELOCITY)
                {
                    [self openSimilarProperties:NO];
                }
                else
                {
                    [self openSimilarProperties:YES];
                }
            }
            else
            {
                if (gestureVelocity.y <= -PANNING_VELOCITY)
                {
                    [self openSimilarProperties:YES];
                }
                else
                {
                    [self openSimilarProperties:NO];
                }
            }
        }else{
            self.view.center = CGPointMake(self.view.center.x, currentCenterCoordinate);
        }
        
    }
    
    [recognizer setTranslation:CGPointZero inView: self.view.superview];
}

- (IBAction)handleTapOnVSP:(UITapGestureRecognizer *)recognizer {
    
    if (isSimilarPropertyViewVisible) {
        [self openSimilarProperties:NO];
    }else{
        [self openSimilarProperties:YES];
    }
}


#pragma mark - View Similar Properties
- (void)openSimilarProperties:(BOOL) isToBeOpenned
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:VSP_TRANSITION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (isToBeOpenned)
    {
        self.view.center = CGPointMake(self.view.center.x, self.view.superview.center.y + VSP_BUTTON_HEIGHT);
        
        isSimilarPropertyViewVisible = YES;
    }
    else
    {
        self.view.center = CGPointMake(self.view.center.x, 2*self.view.superview.center.y + self.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
        
        isSimilarPropertyViewVisible = NO;
    }
    
    [UIView commitAnimations];
    
    
    if (isSimilarPropertyViewVisible) {
        self.disclosureImageView.image = [UIImage imageNamed:@"closeDrawer"];
        self.similarTitleLabel.text = @"Close Drawer";
        self.view.userInteractionEnabled = YES;
        self.view.superview.userInteractionEnabled = YES;
    }
    else
    {
        self.disclosureImageView.image = [UIImage imageNamed:@"openDrawer"];
        self.similarTitleLabel.text = @"Open Drawer";
        self.view.userInteractionEnabled = YES;
        self.view.superview.userInteractionEnabled = YES;
    }
}

@end
