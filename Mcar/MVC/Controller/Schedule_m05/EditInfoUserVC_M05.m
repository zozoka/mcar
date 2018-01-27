//
//  EditInfoUserVC_M05.m
//  Mcar
//
//  Created by thanh tung on 11/7/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "EditInfoUserVC_M05.h"

@interface EditInfoUserVC_M05 ()

@end

@implementation EditInfoUserVC_M05

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errorLabel.layer.cornerRadius = 5;
    self.errorLabel.layer.masksToBounds = YES;
    self.userNameTextField.text = self.session.userFullName;
    self.phoneNumberTextField.text = self.session.userPhone;
    self.emailTextField.text = self.session.userEmail;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneButtonTap:(UIButton *)sender {
    BOOL errorName,errorPhone,errorEmail;
    if(self.userNameTextField.text.length == 0 || [self.userNameTextField.text isEqualToString:@""] || self.userNameTextField.text == nil){
        errorName = YES;
        self.userNameTextField.layer.borderWidth = 0.5;
        self.userNameTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.userNameTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
    }else{
        errorName = NO;
        self.errorLabel.hidden = YES;
        self.userNameTextField.layer.borderWidth = 0.5;
        self.userNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.userNameTextField.layer.cornerRadius = 5;
    }
    if (self.phoneNumberTextField.text.length == 0 || [self.phoneNumberTextField.text isEqualToString:@""] || self.phoneNumberTextField.text == nil) {
        errorPhone = YES;
        self.phoneNumberTextField.layer.borderWidth = 0.5;
        self.phoneNumberTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.phoneNumberTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
    }else{
        errorPhone = NO;
        self.phoneNumberTextField.layer.borderWidth = 0.5;
        self.phoneNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.phoneNumberTextField.layer.cornerRadius = 5;
        self.errorLabel.hidden = YES;
    }
    
    if (self.emailTextField.text.length == 0 || [self.emailTextField.text isEqualToString:@""] || self.emailTextField.text == nil) {
        errorEmail = YES;
        self.emailTextField.layer.borderWidth = 0.5;
        self.emailTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.emailTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
    }else{
        errorEmail = NO;
        self.errorLabel.hidden = YES;
        self.emailTextField.layer.borderWidth = 0.5;
        self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.emailTextField.layer.cornerRadius = 5;
    }
    
    if (!errorName && !errorEmail && !errorPhone) {
        self.session.userFullName = self.userNameTextField.text;
        self.session.userPhone = self.phoneNumberTextField.text;
        self.session.userEmail = self.emailTextField.text;
        [self.session save];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
