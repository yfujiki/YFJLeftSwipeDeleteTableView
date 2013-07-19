//
//  YFJLeftSwipeDeleteTableView.h
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 6/27/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFJLeftSwipeDeleteTableView : UITableView <UIGestureRecognizerDelegate>

//- (void) initWithFrame:(CGRect)frame style:(UITableViewStyle)style otherMenuCells:(NSArray *)menuCells;
//- (void) initWithFrame:(CGRect)frame otherMenuCells:(NSArray *)menuCells;

- (void) setDeleteButtonTitle:(NSString *)title;
- (void) setDeleteButtonAction:(void (^)(NSIndexPath *))deleteAction;

@end
