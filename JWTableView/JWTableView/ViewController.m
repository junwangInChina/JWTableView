//
//  ViewController.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "ViewController.h"

#import "JWTableView/JWTableViewDefine.h"

#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JWTableView *testTabView;
@property (nonatomic, strong) NSArray *testArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"测试";
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.testArray = @[];
    
    [self reloadTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy loading
- (JWTableView *)testTabView
{
    if (!_testTabView)
    {
        self.testTabView = [[JWTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _testTabView.delegate = self;
        _testTabView.dataSource = self;
        _testTabView.backgroundColor = self.view.backgroundColor;
        [_testTabView registerClass:[JWTableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
        [_testTabView configZeroFootView];
        [_testTabView configCustomSeparator];
        _testTabView.emptyTopMargin = 10;
        _testTabView.emptyBgColor = [UIColor greenColor];
        [_testTabView configLoadingTitle:@"正在努力加载中..." image:@"JW_show"];
        [_testTabView configEmptyTitle:@"没有数据哟" image:@"JW_show" handler:@"一键报修"];
        [_testTabView configErrorTitle:@"请求失败了哦" image:@"JW_show" handler:@""];
        
        [self.view addSubview:_testTabView];
        
        __weak __typeof(self)this = self;
        [self.testTabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(this.view).with.insets(UIEdgeInsetsZero);
        }];
        
        _testTabView.errorHandler = ^(){
            NSLog(@"点击重试了哦");
            [this.testTabView setStateViewShow:YES withState:JWTableViewStateLoading];
        };
        
        _testTabView.emptyHandler = ^(){
            NSLog(@"点击一键报修了哦");
        };
    }
    return _testTabView;
}

#pragma mark - Private Method
- (void)loadData:(void(^)(bool refresh))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
//        self.testArray = @[@{@"title":@"表格数据1",@"content":@"表格内容1"},
//                           @{@"title":@"表格数据2",@"content":@"表格内容2"},
//                           @{@"title":@"表格数据3",@"content":@"表格内容3"},
//                           @{@"title":@"表格数据4",@"content":@"表格内容4"},
//                           @{@"title":@"表格数据5",@"content":@"表格内容5"},
//                           @{@"title":@"表格数据6",@"content":@"表格内容6"},
//                           @{@"title":@"表格数据7",@"content":@"表格内容7"}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            !complete ?: complete(self.testArray.count > 0);
        });
    });
}

- (void)reloadTableView
{
    __weak __typeof(self)this = self;
    [self loadData:^(bool refresh) {
        if (refresh)
        {
            [this.testTabView reloadData];
        }
        else
        {
            [this.testTabView setStateViewShow:YES withState:JWTableViewStateEmpty];
        }
    }];
}

#pragma mark - UITableView Delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"
                                                            forIndexPath:indexPath];
    [cell configCustomSeparator:YES color:nil];
    [cell configCommonSeparatorInsert:JWSeparatorInsertMake(10,10)
                  lastSeparatorInsert:JWSeparatorInsertMake(0,0)];
    [cell isLastCell:self.testArray.count == indexPath.row + 1];
    
    cell.textLabel.text = self.testArray[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
