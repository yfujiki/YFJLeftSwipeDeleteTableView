//
//  YFJLeftSwipeDeleteTableView.m
//
//  Provides drop-in TableView component that allows to show iOS7 style left-swipe delete
//
//  Created by Yuichi Fujiki on 6/27/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import "YFJLeftSwipeDeleteTableView.h"
#import "YFJMenuButton.h"
#import "UIButton+NSIndexPath.h"

const static CGFloat kDeleteButtonWidth = 80.f;
const static CGFloat kDeleteButtonHeight = 44.f;
static NSArray * kOtherMenuButtonColors;

#define screenWidth() (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

@interface YFJLeftSwipeDeleteTableView() {
    UISwipeGestureRecognizer * _leftGestureRecognizer;
    UISwipeGestureRecognizer * _rightGestureRecognizer;
    UITapGestureRecognizer * _tapGestureRecognizer;

    UIButton * _deleteButton;
    UIButton * _secondButton;
    UIButton * _thirdButton;

    NSIndexPath * _editingIndexPath;
}

@property (nonatomic, copy) void(^deleteActionBlock)(NSIndexPath *);

@end

@implementation YFJLeftSwipeDeleteTableView

+ (void)initialize {
    kOtherMenuButtonColors = @[[UIColor lightGrayColor], [UIColor colorWithRed:0.f green:1.f blue:0.f alpha:1.f]];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        _leftGestureRecognizer.delegate = self;
        [self addGestureRecognizer:_leftGestureRecognizer];

        _rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _rightGestureRecognizer.delegate = self;
        _rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_rightGestureRecognizer];

        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        _tapGestureRecognizer.delegate = self;
        // Don't add this yet

        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(screenWidth(), 0, kDeleteButtonWidth, kDeleteButtonHeight);
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];

        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style secondMenuButton:(YFJMenuButton *)secondMenuButton thirdMenuButton:(YFJMenuButton *)thirdMenuButton {
    self = [self initWithFrame:frame style:style];
    if(self){
        _secondButton = secondMenuButton;
        _secondButton.frame = CGRectMake(screenWidth() + kDeleteButtonWidth, 0, kDeleteButtonWidth, kDeleteButtonHeight);
        if(!_secondButton.backgroundColor)
            _secondButton.backgroundColor = [UIColor lightGrayColor];
        _secondButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_secondButton];

        if(thirdMenuButton) {
            _thirdButton = thirdMenuButton;
            _thirdButton.frame = CGRectMake(screenWidth() + kDeleteButtonWidth * 2, 0, kDeleteButtonWidth, kDeleteButtonHeight);
            if(!_thirdButton.backgroundColor)
                _thirdButton.backgroundColor = [UIColor colorWithRed:0.f green:1.f blue:0.f alpha:1.f];
            _thirdButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            [self addSubview:_thirdButton];
        }
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame secondMenuButton:(YFJMenuButton *)secondMenuButton thirdMenuButton:(YFJMenuButton *)thirdMenuButton {
    return [self initWithFrame:frame style:UITableViewStylePlain secondMenuButton:secondMenuButton thirdMenuButton:thirdMenuButton];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // drawing code
 }
 */

- (void)swiped:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSIndexPath * indexPath = [self cellIndexPathForGestureRecognizer:gestureRecognizer];
    if(indexPath == nil)
        return;

    if(![self.dataSource tableView:self canEditRowAtIndexPath:indexPath]) {
        return;
    }

    if(gestureRecognizer == _leftGestureRecognizer && ![_editingIndexPath isEqual:indexPath]) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:YES atIndexPath:indexPath cell:cell];
    } else if (gestureRecognizer == _rightGestureRecognizer && [_editingIndexPath isEqual:indexPath]){
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:NO atIndexPath:indexPath cell:cell];
    }
}

- (void)tapped:(UIGestureRecognizer *)gestureRecognizer
{
    if(_editingIndexPath) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:_editingIndexPath];
        [self setEditing:NO atIndexPath:_editingIndexPath cell:cell];
    }
}

- (NSIndexPath *)cellIndexPathForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    UIView * view = gestureRecognizer.view;
    if(![view isKindOfClass:[UITableView class]]) {
        return nil;
    }

    CGPoint point = [gestureRecognizer locationInView:view];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    return indexPath;
}

- (void)setEditing:(BOOL)editing atIndexPath:indexPath cell:(UITableViewCell *)cell {

    if(editing) {
        if(_editingIndexPath) {
            UITableViewCell * editingCell = [self cellForRowAtIndexPath:_editingIndexPath];
            [self setEditing:NO atIndexPath:_editingIndexPath cell:editingCell];
        }
        [self addGestureRecognizer:_tapGestureRecognizer];
    } else {
        [self removeGestureRecognizer:_tapGestureRecognizer];
    }

    CGRect frame = cell.frame;

    CGFloat cellXOffset;
    CGFloat deleteButtonXOffsetOld, deleteButtonXOffset;
    CGFloat secondButtonXOffsetOld, secondButtonXOffset;
    CGFloat thirdButtonXOffsetOld, thirdButtonXOffset;

    CGFloat buttonsWidth = kDeleteButtonWidth;
    if(_secondButton)
        buttonsWidth += kDeleteButtonWidth;
    if(_thirdButton)
        buttonsWidth += kDeleteButtonWidth;

    if(editing) {
        cellXOffset = -buttonsWidth;
        deleteButtonXOffset = screenWidth() - buttonsWidth;
        deleteButtonXOffsetOld = screenWidth();
        secondButtonXOffset = deleteButtonXOffset + kDeleteButtonWidth;
        secondButtonXOffsetOld = screenWidth() + kDeleteButtonWidth;
        thirdButtonXOffset = secondButtonXOffset + kDeleteButtonWidth;
        thirdButtonXOffsetOld = screenWidth() + 2 * kDeleteButtonWidth;
        _editingIndexPath = indexPath;
    } else {
        cellXOffset = 0;
        deleteButtonXOffset = screenWidth();
        deleteButtonXOffsetOld = screenWidth() - buttonsWidth;
        secondButtonXOffset = screenWidth() + kDeleteButtonWidth;
        secondButtonXOffsetOld = screenWidth() - buttonsWidth + kDeleteButtonWidth;
        thirdButtonXOffset = screenWidth() + kDeleteButtonWidth * 2;
        thirdButtonXOffsetOld = screenWidth() - buttonsWidth + kDeleteButtonWidth * 2;
        _editingIndexPath = nil;
    }

    CGFloat cellHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
    _deleteButton.frame = (CGRect) {deleteButtonXOffsetOld, frame.origin.y, _deleteButton.frame.size.width, cellHeight};
    _deleteButton.indexPath = indexPath;
    _secondButton.frame = (CGRect) {secondButtonXOffsetOld, frame.origin.y, _secondButton.frame.size.width, cellHeight};
    _secondButton.indexPath = indexPath;
    _thirdButton.frame = (CGRect) {thirdButtonXOffsetOld, frame.origin.y, _thirdButton.frame.size.width, cellHeight};
    _thirdButton.indexPath = indexPath;

    [UIView animateWithDuration:0.2f animations:^{
        cell.frame = CGRectMake(cellXOffset, frame.origin.y, frame.size.width, frame.size.height);
        _deleteButton.frame = (CGRect) {deleteButtonXOffset, frame.origin.y, _deleteButton.frame.size.width, cellHeight};
        _secondButton.frame = (CGRect) {secondButtonXOffset, frame.origin.y, _secondButton.frame.size.width, cellHeight};
        _thirdButton.frame = (CGRect) {thirdButtonXOffset, frame.origin.y, _thirdButton.frame.size.width, cellHeight};
    }];
}

#pragma mark - Interaciton
- (void)deleteItem:(id)sender {
    UIButton * deleteButton = (UIButton *)sender;
    NSIndexPath * indexPath = deleteButton.indexPath;

    if(self.deleteActionBlock) {
        self.deleteActionBlock(indexPath);
    }

    [self.dataSource tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];

    _editingIndexPath = nil;

    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){frame.origin, frame.size.width, 0};
        frame = _secondButton.frame;
        _secondButton.frame = (CGRect){frame.origin, frame.size.width, 0};
        frame = _thirdButton.frame;
        _thirdButton.frame = (CGRect){frame.origin, frame.size.width, 0};
    } completion:^(BOOL finished) {
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
        frame = _secondButton.frame;
        _secondButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
        frame = _thirdButton.frame;
        _thirdButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
    }];
}

#pragma mark - Customize Delete Button
- (void) setDeleteButtonTitle:(NSString *)title {
    [_deleteButton setTitle:title forState:UIControlStateNormal];
}

- (void) setDeleteButtonAction:(void (^)(NSIndexPath *))deleteAction {
    self.deleteActionBlock = deleteAction;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO; // Recognizers of this class are the first priority
}

@end
