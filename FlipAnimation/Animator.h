//
//  Animator.h
//  Design Inspiration
//
//  Created by Rounak Jain on 13/03/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animator : NSObject  <UIViewControllerAnimatedTransitioning>
@property UINavigationControllerOperation animationType;
@end
