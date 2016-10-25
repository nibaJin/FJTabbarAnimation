//
//  FJTabbarVCDelegate.m
//  Tarbar
//
//  Created by fujin on 16/9/1.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "FJTabbarVCDelegate.h"
#import "FJTabbarAnimation.h"

@interface FJTabbarVCDelegate ()

@property (nonatomic, strong) FJTabbarAnimation *tabbarAnimtion;

@end

@implementation FJTabbarVCDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        _tabbarAnimtion = [[FJTabbarAnimation alloc] init];
    }
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController
{
    return _interactiveState ? _interactiveTransition : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    _tabbarAnimtion.tabOperationDirection = toIndex < fromIndex ? TabOperationDirectionLeft :TabOperationDirectionRight ;
    
    return _tabbarAnimtion;
}

@end
