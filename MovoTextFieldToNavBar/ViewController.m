//
//  ViewController.m
//  MovoTextFieldToNavBar
//
//  Created by 王少帅 on 2017/12/25.
//  Copyright © 2017年 王少帅. All rights reserved.
//

#import "ViewController.h"
#import "TextFieldView.h"

#define kWIDTH        [UIScreen mainScreen].bounds.size.width
#define kHEIGHT       [UIScreen mainScreen].bounds.size.height
#define kRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *navBarView;
@property(nonatomic, strong) UILabel *navTitleLabel;
@property(nonatomic, strong) TextFieldView *textFieldView;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    //背景颜色
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //一个假的navbar
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 64)];
    [self.view addSubview:self.navBarView];
    self.navBarView.backgroundColor = [UIColor whiteColor];
    
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kWIDTH, 44)];
    [self.view addSubview:self.navTitleLabel];
    self.navTitleLabel.textAlignment = 1;
    self.navTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.navTitleLabel.text = @"移动输入框Demo";
    self.navTitleLabel.textColor = [UIColor colorWithRed:0.16 green:0.17 blue:0.20 alpha:1.00];
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 20+10, 44-10-10, 44-10-10)];
    [popButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:popButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = 0;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
    self.textFieldView = [[TextFieldView alloc] initWithFrame:CGRectMake(10, 64+7, kWIDTH-10-10, 44-7-7)];
    self.textFieldView.layer.masksToBounds = YES;
    self.textFieldView.layer.cornerRadius = self.textFieldView.frame.size.height*0.5;
    [self.view addSubview:self.textFieldView];

}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offset_y = offset.y;
        NSLog(@"偏移量offset_y = %.2f",offset_y);
        
        if (offset_y <= 0.00)
        {
            CGFloat x = 10;
            CGFloat y = (64+7) - (((64+7) - (20+7)) / 44.000 * offset_y);
            CGFloat w = kWIDTH-10-10;
            CGFloat h = 44-7-7;
            self.textFieldView.frame = CGRectMake(x, y, w, h);
            self.navTitleLabel.textColor = [UIColor colorWithRed:0.16 green:0.17 blue:0.20 alpha:1.00];
        }
        else if (offset_y >= 44.00)
        {
            self.textFieldView.frame = CGRectMake(44, 20+7, kWIDTH-44-10, 44-7-7);
            self.navTitleLabel.textColor = [[UIColor colorWithRed:0.16 green:0.17 blue:0.20 alpha:1.00] colorWithAlphaComponent:0];
        }
        else
        {
            CGFloat x = (44 - 10) / 44.000 * offset_y + (10);
            CGFloat y = (64+7) - (((64+7) - (20+7)) / 44.000 * offset_y);
            CGFloat w = (kWIDTH-10-10) - (((kWIDTH-10-10) - (kWIDTH-44-10)) / 44.000 * offset_y);
            CGFloat h = 44-7-7;
            self.textFieldView.frame = CGRectMake(x, y, w, h);
            self.navTitleLabel.textColor = [[UIColor colorWithRed:0.16 green:0.17 blue:0.20 alpha:1.00] colorWithAlphaComponent:(1 - (offset_y / 44.000))];
        }
    }
}

#pragma mark - tableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = 0;
    }
    cell.backgroundColor = kRandomColor;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
