//
//  YFJMenuCell.m
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 7/19/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import "YFJMenuButton.h"
#import "UIButton+NSIndexPath.h"

@interface YFJMenuButton()

@property (nonatomic, copy) void (^actionBlock)(NSIndexPath *);

@end

@implementation YFJMenuButton

- (id) initWithTitle:(NSString *)title backgroundColor:(UIColor *)color actionBlock:(void (^)(NSIndexPath *))actionBlock {
    self = [YFJMenuButton buttonWithType:UIButtonTypeCustom];
    if(self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundColor:color];
        [self setActionBlock:actionBlock];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = (UITouch *)[touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(self.bounds, point)) {
        self.actionBlock(self.indexPath);
    }
}
@end
