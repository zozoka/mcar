//
//  M04_NotifyNoteVC.m
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "M04_NotifyNoteVC.h"

@interface M04_NotifyNoteVC ()

@end

@implementation M04_NotifyNoteVC
NSArray *arrData;
UIRefreshControl *refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self configTableView];
    self.tableView.hidden = YES;
    [self loadDataFromJson];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)refreshTable {
    //TODO: refresh your data
    [self loadDataFromJson];
}

#pragma mark config UI
- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"NotifyCell" bundle:nil] forCellReuseIdentifier:@"NotifyCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark network

- (void)loadDataFromJson{
    NSDictionary *param = @{@"api_token":self.session.uniqueToken};
    [self.networkManager requestGetNewsNotify:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        NewsApiJsonModel *newsApiJsonModel = [[NewsApiJsonModel alloc]initWithDictionary:responseDict error:&error];
        arrData = newsApiJsonModel.data;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier1 = @"NotifyCell";
    NotifyCell *cell = (NotifyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell)
    {
        cell = [[NotifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImageView.image = [UIImage imageNamed:@"logo-mcar-icon.png"];
    NSError *error;
    NewsJsonModel *newsJson = [[NewsJsonModel alloc]initWithDictionary:arrData[indexPath.row] error:&error];
    
    cell.titleLabel.text = newsJson.title;
    cell.contentLabel.text = newsJson.body;
    
    //date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatterOut = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatterOut setDateFormat:@"dd-MM-yyyy"];
    NSDate *createAt = [[NSDate alloc]init];
    createAt = [dateFormatter dateFromString:newsJson.created_at];
    NSString * createAtString = [dateFormatterOut stringFromDate:createAt];
    cell.dateTimeLabel.text = createAtString;
    return cell;
}

@end
