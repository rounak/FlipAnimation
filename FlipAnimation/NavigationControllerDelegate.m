//
//  NavigationControllerDelegate.m
//  Design Inspiration
//
//  Created by Rounak Jain on 05/01/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Animator.h"

@interface NavigationControllerDelegate ()
@property UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation NavigationControllerDelegate

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setNavigationController:(UINavigationController *)navigationController
{
    _navigationController = navigationController;
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGestureRecognizer.edges = UIRectEdgeLeft;
    [_navigationController.view addGestureRecognizer:panGestureRecognizer];
}
#pragma mark - Animation methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    return [self animatorForOperation:operation fromViewController:fromVC toViewController:toVC];
}

#pragma mark - Interactive animation methods

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

- (void)pan:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    UIView* view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [UIPercentDrivenInteractiveTransition new];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animatorForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController*)fromVC
                                                  toViewController:(UIViewController*)toVC
{
    Animator *animator = [[Animator alloc] init];
    animator.animationType = operation;
    return animator;
}

@end