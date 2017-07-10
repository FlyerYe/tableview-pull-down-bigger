//
//  ViewController.m
//  tableview下拉放大
//
//  Created by 付野 on 2017/5/9.
//  Copyright © 2017年 com.1School. All rights reserved.
//

#import "ViewController.h"
#define kHeight 250

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    _tableview.contentInset = UIEdgeInsetsMake(kHeight, 0, 0, 0);
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHeight, self.view.frame.size.width, kHeight)];
    imageview.image = [UIImage imageNamed:@"123.jpg"];
    //图片宽高比一定要大于设定宽高比
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.tag = 101;
    [_tableview addSubview:imageview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld", indexPath.section, indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%f", point.y);
    if (point.y < -kHeight) {
        CGRect rect = [_tableview viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = - point.y;
        [_tableview viewWithTag:101].frame = rect;
        NSLog(@"%f",rect.size.height);
    }
}

@end
