//
//  MenuViewController.m
//  YFJLeftSwipeDeleteTableView
//
//  Created by Yuichi Fujiki on 7/19/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"

NS_ENUM(NSUInteger, YFJ_EXAMPLE_MENU) {
    YFJ_EXAMPLE_MENU_NORMAL = 0,
    YFJ_EXAMPLE_MENU_CUSTOMIZE_DELETE_BUTTON,
    YFJ_EXAMPLE_MENU_MORE_BUTTONS,
    YFJ_EXAMPLE_MENU_COUNT
};

@interface MenuViewController ()

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Examples";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = self.view.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menuCell"];

    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return YFJ_EXAMPLE_MENU_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"menuCell"];

    switch (indexPath.row) {
        case YFJ_EXAMPLE_MENU_NORMAL:
            [cell.textLabel setText:@"Simple"];
            break;
        case YFJ_EXAMPLE_MENU_CUSTOMIZE_DELETE_BUTTON:
            [cell.textLabel setText:@"Customize Delete Button"];
            break;
        case YFJ_EXAMPLE_MENU_MORE_BUTTONS:
            [cell.textLabel setText:@"More Than One Button"];
            break;
        default:
            NSAssert(NO, @"Should not reach here");
            break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case YFJ_EXAMPLE_MENU_NORMAL:
        {
            ViewController1 * vc = [[ViewController1 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case YFJ_EXAMPLE_MENU_CUSTOMIZE_DELETE_BUTTON:
        {
            ViewController2 * vc = [[ViewController2 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case YFJ_EXAMPLE_MENU_MORE_BUTTONS:
        {
            ViewController3 * vc = [[ViewController3 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            NSAssert(NO, @"Should not reach here");
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
