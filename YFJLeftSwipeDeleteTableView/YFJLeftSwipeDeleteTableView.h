//
//  YFJLeftSwipeDeleteTableView.h
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 6/27/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFJMenuButton;

@interface YFJLeftSwipeDeleteTableView : UITableView <UIGestureRecognizerDelegate>

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style secondMenuButton:(YFJMenuButton *)secondMenuButton thirdMenuButton:(YFJMenuButton *)thirdMenuButton;
- (id) initWithFrame:(CGRect)frame secondMenuButton:(YFJMenuButton *)secondMenuButton thirdMenuButton:(YFJMenuButton *)thirdMenuButton;

- (void) setDeleteButtonTitle:(NSString *)title;
- (void) setDeleteButtonAction:(void (^)(NSIndexPath *))deleteAction;

@end
