//
//  CommentVC.m
//  Mcar
//
//  Created by thanh tung on 10/19/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "CommentVC.h"

@interface CommentVC ()

@end

@implementation CommentVC
NSInteger indexButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    self.garaTitleLabel.text = self.garageJsonModel.name;
    self.addressLabel.text = self.garageJsonModel.address;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    self.heightBottomView.constant = keyboardFrame.size.height;
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
}

-(void)keyboardHidden:(NSNotification *)notification{
    self.heightBottomView.constant = 0.0;
}

- (IBAction)sentButtonTap:(UIButton *)sender {
    [self.view endEditing:YES];
    NSNumber *ratingNumber = [NSNumber numberWithInteger:indexButton*2] ;
    if (ratingNumber != 0) {
        NSDictionary *paramRate = @{@"api_token":self.session.uniqueToken,
                                    @"rating":ratingNumber
                                    };
        [self.networkManager requestPostRating:self.garageJsonModel.idGarage parameter:paramRate comletion:^(NSDictionary *responseDict) {
            NSError *error;
            RatingApiJsonModel *ratingApiJsonModel = [[RatingApiJsonModel alloc]initWithDictionary:responseDict error:&error];
            if ([ratingApiJsonModel.status intValue] ==  1) {
                NSLog(@"rate: %@",ratingNumber);
            }
        }];
    }
    NSDictionary *param = @{@"api_token":self.session.uniqueToken,
                            @"content":self.commentTextView.text
                            };
    [self.networkManager requestPostComment:self.garageJsonModel.idGarage parameter:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        CommentApiJsonModel *commentApiJsonModel = [[CommentApiJsonModel alloc]initWithDictionary:responseDict error:&error];
        if ([commentApiJsonModel.status intValue] == 1) {
            [[MCGlobal shareGlobal] showMessage:@"Bình luận của bạn đã được gửi" inView:self action:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            //[[MCGlobal shareGlobal] showMessage:@"Bình luận của bạn đã được gửi" inView:self];
        }
    }];
}
- (IBAction)backButtonTap:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ratingStarsButtonTap:(UIButton *)sender {
    indexButton = sender.tag;
    for (int i = 1; i <= 5; i++) {
        for (UIView *viewBt in self.ratingView.subviews) {
            if ([viewBt isKindOfClass:[UIButton class]]) {
                UIButton *ratingBt = (UIButton*)viewBt;
                if (ratingBt.tag == i && ratingBt.tag <= indexButton) {
                    [ratingBt setImage:[UIImage imageNamed:@"M11_sao2.png"] forState:UIControlStateNormal];
                    NSLog(@"rate button active: %ld",(long)ratingBt.tag);
                }else if(ratingBt.tag == i && ratingBt.tag > indexButton){
                    [ratingBt setImage:[UIImage imageNamed:@"M11_sao1.png"] forState:UIControlStateNormal];
                    //[ratingBt setImage:[UIImage imageNamed:@"M09_Star.png"] forState:UIControlStateNormal];
                    NSLog(@"rate button diactive: %ld",(long)ratingBt.tag);
                }
            }
        }
    }
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
