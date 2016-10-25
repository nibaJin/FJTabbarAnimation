//
//  FJTabbarVCDelegate.h
//  Tarbar
//
//  Created by fujin on 16/9/1.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FJTabbarVCDelegate : NSObject<UITabBarControllerDelegate>

@property (nonatomic, assign) BOOL interactiveState;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end
