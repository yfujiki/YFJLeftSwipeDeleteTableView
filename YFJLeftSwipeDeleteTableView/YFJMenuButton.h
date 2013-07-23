//
//  YFJMenuButton.h
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 7/19/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFJMenuButton : UIButton

- (id) initWithTitle:(NSString *)title backgroundColor:(UIColor *)color actionBlock:(void (^)(NSIndexPath *))actionBlock;

@end
