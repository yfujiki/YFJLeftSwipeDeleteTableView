//
//  UIButton+NSIndexPath.m
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 7/19/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import "UIButton+NSIndexPath.h"
#import <objc/runtime.h>

@implementation UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, kYFJLeftSwipeDeleteTableViewCellIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)indexPath {
    id obj = objc_getAssociatedObject(self, kYFJLeftSwipeDeleteTableViewCellIndexPathKey);
    if([obj isKindOfClass:[NSIndexPath class]]) {
        return (NSIndexPath *)obj;
    }
    return nil;
}

@end

