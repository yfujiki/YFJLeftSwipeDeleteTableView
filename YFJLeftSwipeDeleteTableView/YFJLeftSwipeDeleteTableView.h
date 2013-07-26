//
//  YFJLeftSwipeDeleteTableView.h
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 6/27/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFJLeftSwipeDeleteTableViewDelegate <NSObject>

@required
- (BOOL) yfjTableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YFJLeftSwipeDeleteTableView : UITableView <UIGestureRecognizerDelegate>

@property (weak) id <YFJLeftSwipeDeleteTableViewDelegate> yfjDelegate;

@end
