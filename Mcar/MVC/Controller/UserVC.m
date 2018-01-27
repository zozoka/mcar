//
//  UserVC.m
//  Mcar
//
//  Created by thanh tung on 9/26/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "UserVC.h"

@interface UserVC ()

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    [self setupDataTableView];
    
}

- (void)setupDataTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"userCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    
    self.arrDataTable = [[NSMutableArray alloc]init];
    MenuUserModel *menu = [[MenuUserModel alloc]init];
    menu.title = @"Danh sách xe";
    menu.imageName = @"m01-icon-danhsach";
    [self.arrDataTable addObject:menu];
    
    MenuUserModel *menu1 = [[MenuUserModel alloc]init];
    menu1.title = @"Lịch sử đặt lịch hẹn";
    menu1.imageName = @"m01-icon-lichhen";
    [self.arrDataTable addObject:menu1];
    
    MenuUserModel *menu2 = [[MenuUserModel alloc]init];
    menu2.title = @"Danh sách garage yêu thích";
    menu2.imageName = @"m01-icon-danhsachgaraga";
    [self.arrDataTable addObject:menu2];
    
    MenuUserModel *menu3 = [[MenuUserModel alloc]init];
    menu3.title = @"Giới thiệu bạn bè (nhận ưu đãi)";
    menu3.imageName = @"m01-icon-gioithieubanbe";
    [self.arrDataTable addObject:menu3];
    
    MenuUserModel *menu4 = [[MenuUserModel alloc]init];
    menu4.title = @"Live chat hỗ trợ trực tuyến (tư vấn xe)";
    menu4.imageName = @"m01-icon-livechat";
    [self.arrDataTable addObject:menu4];
    
    MenuUserModel *menu5 = [[MenuUserModel alloc]init];
    menu5.title = @"Hỏi đáp, hướng dẫn (cộng đồng xe)";
    menu5.imageName = @"m01-icon-hoidap";
    [self.arrDataTable addObject:menu5];
    
    MenuUserModel *menu6 = [[MenuUserModel alloc]init];
    menu6.title = @"Đánh giá, góp ý, báo lỗi phần mềm";
    menu6.imageName = @"m01-icon-danhgia";
    [self.arrDataTable addObject:menu6];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUI{
    self.userNameLabel.text = self.session.userFullName;
    self.avataImageView.layer.masksToBounds = YES;
    self.avataImageView.layer.cornerRadius = self.avataImageView.frame.size.height/2;
    dispatch_async(dispatch_get_main_queue(), ^(){
        self.sosImageView.image = [self.sosImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.sosImageView setTintColor:[UIColor redColor]];
    });
    [self.avataImageView setImageWithURL:[NSURL URLWithString:self.session.userImageAvataUrl] placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];
}


#pragma mark - tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrDataTable count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuUserModel *menuObj = [self.arrDataTable objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"userCell";
    userCell *cell = (userCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[userCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.iconImageView.image = [UIImage imageNamed:menuObj.imageName];
    cell.titleMenu.text = menuObj.title;
    return cell;
}


#pragma mark - IBAction

- (IBAction)exitButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTap:(UIButton *)sender {
}
- (IBAction)logoutButtonTap:(UIButton *)sender {
    [[MCGlobal shareGlobal]showMessage:OMLang(@"logout") buttonTitle1:@"Cancel" buttonTitle2:@"Ok" inView:self action:^{
        [[GIDSignIn sharedInstance]signOut];
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        [FBSDKAccessToken setCurrentAccessToken:nil];
        AKFAccountKit *accountKit = [[AKFAccountKit alloc]initWithResponseType:AKFResponseTypeAccessToken];
        [accountKit logOut];
        [self.session clearSessionData];
        [self.session save];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //[[MCGlobal shareGlobal] cancelAllNotification];
        
    }];
}

- (IBAction)updateAvataButtonTap:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSString *strImageAssets = [NSString stringWithFormat:@"%@",info[UIImagePickerControllerReferenceURL]];
    
    NSLog(@"%@",strImageAssets);
    
//    self.session.userImageAvataUrl = strImageAssets;
//    self.session.imageFromUrl = NO;
    
    //[self.session save];
    [picker dismissViewControllerAnimated:YES completion:^{
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        indicator.frame = CGRectMake(0, 0, 24, 24);
//        indicator.center = self.avataImageView.center;
//        [self.avataImageView addSubview:indicator];
//        [indicator startAnimating];
        self.avataImageView.image = chosenImage;
        
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
