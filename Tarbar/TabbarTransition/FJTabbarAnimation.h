//
//  FJTabbarAnimation.h
//  Tarbar
//
//  Created by fujin on 16/9/1.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FJTabOperationDirection)
{
    TabOperationDirectionLeft ,
    TabOperationDirectionRight
};

@interface FJTabbarAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) FJTabOperationDirection tabOperationDirection;

@end
