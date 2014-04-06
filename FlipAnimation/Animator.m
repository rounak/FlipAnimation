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
    return 0.25;
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
    [[transitionContext containerView] addSubview:toViewController.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromViewController.view.alpha = 1;
    }];
}

- (void)performPopAnimationFromViewController:(SecondViewController*)fromViewController
                             toViewController:(FirstViewController*)toViewController
                        withTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    toViewController.view.alpha = 0;
    [[transitionContext containerView] addSubview:toViewController.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromViewController.view.alpha = 1;
    }];
}

@end
