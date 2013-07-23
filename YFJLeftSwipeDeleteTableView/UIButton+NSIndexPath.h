//
//  UIButton+NSIndexPath.h
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 7/19/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import <UIKit/UIKit.h>

const static char * kYFJLeftSwipeDeleteTableViewCellIndexPathKey = "YFJLeftSwipeDeleteTableViewCellIndexPathKey";

@interface UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPath;

@end

