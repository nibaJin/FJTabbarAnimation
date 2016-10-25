//
//  TarbarViewController.m
//  Tarbar
//
//  Created by fujin on 15/8/28.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

#import "TarbarViewController.h"
#import "FJTabbarVCDelegate.h"

@interface TarbarViewController ()

@property (nonatomic, strong) FJTabbarVCDelegate *tabbarVCDelegate;

@property (nonatomic, assign) NSInteger subViewControllerCount;

@end

@implementation TarbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers];
    
    _tabbarVCDelegate = [[FJTabbarVCDelegate alloc] init];
    self.delegate = _tabbarVCDelegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
    _subViewControllerCount = self.viewControllers ? self.viewControllers.count : 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setViewControllers{
    //将对应的nav加入
    UINavigationController *CarRentalInex = [self.storyboard instantiateViewControllerWithIdentifier:@"first"];
    UINavigationController *TicketIndex = [self.storyboard instantiateViewControllerWithIdentifier:@"second"];
    UINavigationController *PersonalIndex = [self.storyboard instantiateViewControllerWithIdentifier:@"third"];
    NSArray *controllersArray = @[CarRentalInex,TicketIndex,PersonalIndex];
    self.viewControllers = controllersArray;
    
    //设置item的标题
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Car] setTitle:@"租车"];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Ticket] setTitle:@"机票"];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Personal] setTitle:@"我的"];
    
    //设置item选中和未选中的图标
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Car] setImage:[UIImage imageNamed:@"index_ico_rental_52×52"]];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Car] setSelectedImage:[UIImage imageNamed:@"index_ico_rental_52×52_selected"]];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Ticket] setImage:[UIImage imageNamed:@"index_ico_FlightTicket_52×52"]];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Ticket] setSelectedImage:[UIImage imageNamed:@"index_ico_FlightTicket_52×52_selected"]];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Personal] setImage:[UIImage imageNamed:@"index_ico_my_52×52"]];
    [[self.tabBar.items objectAtIndex:Enum_TabBar_Items_Personal] setSelectedImage:[UIImage imageNamed:@"index_ico_my_52×52_selected"]];
    
    //字体选中和未选中的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0f], NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:93.0/255.0 alpha:1.0f], NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    //改变UITabBarItem的title的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -2.0)];
}


- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat progress = translationAbs / self.view.bounds.size.width;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            _tabbarVCDelegate.interactiveState = YES;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < _subViewControllerCount-1) {
                    self.selectedIndex += 1;
                }
            }else{
                if (self.selectedIndex > 0) {
                    self.selectedIndex -= 1;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [_tabbarVCDelegate.interactiveTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self interactiveComplish:progress];

        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self interactiveComplish:progress];
        }
            break;
        default:
            break;
    }
}

- (void)interactiveComplish:(CGFloat)progress
{
    if (progress > 0.3) {
        _tabbarVCDelegate.interactiveTransition.completionSpeed = 0.99;
        [_tabbarVCDelegate.interactiveTransition finishInteractiveTransition];
    }else{
        _tabbarVCDelegate.interactiveTransition.completionSpeed = 0.99;
        [_tabbarVCDelegate.interactiveTransition cancelInteractiveTransition];
    }
    _tabbarVCDelegate.interactiveState = NO;
}

@end
