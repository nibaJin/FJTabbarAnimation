//
//  FJTabbarAnimation.m
//  Tarbar
//
//  Created by fujin on 16/9/1.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "FJTabbarAnimation.h"

@implementation FJTabbarAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    
    CGFloat width = containerView.frame.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    width = _tabOperationDirection==TabOperationDirectionLeft ? width:-width;
    fromViewTransform = CGAffineTransformMakeTranslation(width, 0);
    toViewTransform = CGAffineTransformMakeTranslation(-width, 0);
    
    [containerView insertSubview:toView aboveSubview:fromView];
    toView.transform = toViewTransform;
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}

@end
