//
//  Animator.m
//  Design Inspiration
//
//  Created by Rounak Jain on 13/03/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "Animator.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation Animator

#pragma mark - UIViewControllerContextTransitioning methods

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}

#pragma mark - UIViewControllerContextTransitioning methods

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    switch (self.animationType) {
        case UINavigationControllerOperationPush:
            if ([fromViewController isKindOfClass:[FirstViewController class]] && [toViewController isKindOfClass:[SecondViewController class]]) {
                [self performPushAnimationFromViewController:(FirstViewController*)fromViewController
                                                          to:(SecondViewController*)toViewController
                                       withTransitionContext:transitionContext];
            }
            break;
        case UINavigationControllerOperationPop:
            if ([fromViewController isKindOfClass:[SecondViewController class]] && [toViewController isKindOfClass:[FirstViewController class]]) {
                [self performPopAnimationFromViewController:(SecondViewController*)fromViewController toViewController:(FirstViewController*)toViewController withTransitionContext:transitionContext];
            }
            break;
        default:
            break;
    }
}

- (void)performPushAnimationFromViewController:(FirstViewController*)fromViewController
                                            to:(SecondViewController*)toViewController
                         withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //set the second ViewController's transform such that it can continue from where the tapView button animation stops. That is the angle should be 90 degrees, and the dimensions of the two views must match. So scale down toViewController
    toViewController.view.alpha = 0;
    toViewController.view.layer.transform = CATransform3DRotate(CATransform3DScale(toViewController.view.layer.transform, 0.6, 0.6, 1) , -M_PI_2, 0, 1, 0);
    [[transitionContext containerView] addSubview:toViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //rotate tapView 90 degree, and simultaneously scale it up by 1.2 across x and y axes.
        CATransform3D rotateTransform = CATransform3DRotate(CATransform3DScale(fromViewController.tapView.layer.transform, 1.2, 1.2, 1), M_PI_2, 0, 1, 0);
        fromViewController.tapView.layer.transform = rotateTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toViewController.view.alpha = 1;
            //making it identitiy transform autmatically rotates the view for the remaining angle and gives it the full frame.
            toViewController.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            //reset the tapView's transform to identity now that the animation's done
            fromViewController.tapView.layer.transform = CATransform3DIdentity;
        }];
    }];
}

- (void)performPopAnimationFromViewController:(SecondViewController*)fromViewController
                             toViewController:(FirstViewController*)toViewController
                        withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{

}

@end
