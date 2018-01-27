//
//  UpdateInfoUserVC.m
//  Mcar
//
//  Created by thanh tung on 10/27/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "UpdateInfoUserVC.h"
#import <QuartzCore/QuartzCore.h>

@interface UpdateInfoUserVC ()

@end

@implementation UpdateInfoUserVC
NSNumber *cardBrandID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    [self loadDataCarBrand];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark network
- (void)loadDataCarBrand{
    NSDictionary *param = @{@"":@""};
    [self.networkManager requestGetCarBrand:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        ApiCarBrandJsonModel *apiCardBrandJson = [[ApiCarBrandJsonModel alloc] initWithDictionary:responseDict error:&error];
        self.arrData = apiCardBrandJson.data;
        [self.pickerView reloadAllComponents];
    }];
}


#pragma mark UI
- (void)configUI{
    self.nameTextField.text = self.userJsonModel.name;
    self.mobileTextField.text = self.userJsonModel.phone;
    self.emailTextField.text = self.userJsonModel.email;
    self.errorLabel.layer.cornerRadius = 5;
    self.errorLabel.layer.masksToBounds = YES;
    self.errorLabel.backgroundColor = [UIColor redColor];
    self.errorLabel.hidden = YES;
    //self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/2)];
    //self.pickerView setFrame:<#(CGRect)#>
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    //[self.view addSubview:self.pickerView];
    [self.carbandTextField setInputView:self.inputPickerView];
}

#pragma mark - UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CarBrandsJsonModel *carJson = [[CarBrandsJsonModel alloc] initWithDictionary:self.arrData[row] error:nil];
    return carJson.name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    CarBrandsJsonModel *carJson = [[CarBrandsJsonModel alloc]initWithDictionary:self.arrData[row] error:nil];
    self.carbandTextField.text = carJson.name;
    cardBrandID = carJson.idCarBrand;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)nextButtonTap:(UIButton *)sender {
    BOOL errorName,errorPhone,errorEmail,errorCarBrand,errorNameCar,errorDate,errorCarID;
    if ([self.nameTextField.text isEqualToString:@""] || self.nameTextField.text == nil || self.nameTextField.text.length == 0) {
        self.nameTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.nameTextField.layer.borderWidth = 0.5;
        self.nameTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorName = YES;
    }else{
        
        self.nameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.nameTextField.layer.borderWidth = 0.5;
        self.nameTextField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorName = NO;
    }
    
    if ([self.mobileTextField.text isEqualToString:@""] || self.mobileTextField.text.length == 0 || self.mobileTextField.text == nil){
        self.mobileTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.mobileTextField.layer.borderWidth = 0.5;
        self.mobileTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorPhone = YES;
    }else{
        self.mobileTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.mobileTextField.layer.borderWidth = 0.5;
        self.mobileTextField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorPhone = NO;
    }
    
    if ([self.emailTextField.text isEqualToString:@""] || self.emailTextField.text.length == 0 || self.emailTextField.text == nil) {
        self.emailTextField.layer.borderWidth = 0.5;
        self.emailTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.emailTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorEmail = YES;
    }else{
        self.emailTextField.layer.borderWidth = 0.5;
        self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.emailTextField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorEmail = NO;
    }
    
    if ([self.carbandTextField.text isEqualToString:@""] || self.carbandTextField.text.length == 0 || self.carbandTextField.text == nil) {
        self.carbandTextField.layer.borderWidth = 0.5;
        self.carbandTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.carbandTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorCarBrand = YES;
    }else{
        self.carbandTextField.layer.borderWidth = 0.5;
        self.carbandTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.carbandTextField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorCarBrand = NO;
    }
    
    if ([self.nameCarTextField.text isEqualToString:@""] || self.nameCarTextField.text.length == 0 || self.nameCarTextField.text == nil) {
        self.nameCarTextField.layer.borderWidth = 0.5;
        self.nameCarTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.nameCarTextField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorNameCar = YES;
    }else{
        self.nameCarTextField.layer.borderWidth = 0.5;
        self.nameCarTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.nameCarTextField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorNameCar = NO;
    }
    
    if ([self.numberField.text isEqualToString:@""] || self.numberField.text.length == 0 || self.numberField.text == nil) {
        self.numberField.layer.borderWidth = 0.5;
        self.numberField.layer.borderColor = [UIColor redColor].CGColor;
        self.numberField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorDate = YES;
    }else{
        self.numberField.layer.borderWidth = 0.5;
        self.numberField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.numberField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorDate = NO;
    }
    
    if ([self.carmunberField.text isEqualToString:@""] || self.carmunberField.text.length == 0 || self.carmunberField.text == nil) {
        self.carmunberField.layer.borderWidth = 0.5;
        self.carmunberField.layer.borderColor = [UIColor redColor].CGColor;
        self.carmunberField.layer.cornerRadius = 5;
        self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = NO;
        errorCarID = YES;
    }else{
        self.carmunberField.layer.borderWidth = 0.5;
        self.carmunberField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.carmunberField.layer.cornerRadius = 5;
        //self.errorLabel.text = @"Bạn phải nhập đầy đủ thông tin để tiếp tục.";
        self.errorLabel.hidden = YES;
        errorCarID = NO;
    }
    if (errorName == NO && errorPhone == NO && errorEmail == NO && errorCarBrand == NO && errorNameCar == NO && errorDate == NO && errorCarID == NO) {
        NSDictionary *param = @{@"api_token":self.session.uniqueToken,
                                @"name": self.nameTextField.text,
                                @"phone": self.mobileTextField.text,
                                @"email": self.emailTextField.text
                                };
        [self.networkManager requestPutUpdateUserInfo:param comletion:^(NSDictionary *responseDict) {
            NSError *error;
            UpdateInfoUserApiJsonModel *updateApiJsonModel = [[UpdateInfoUserApiJsonModel alloc] initWithDictionary:responseDict error:&error];
            if ([updateApiJsonModel.status intValue] == 1) {
                NSLog(@"update info user ok!");
                self.session.userFullName = self.nameTextField.text;
                self.session.userPhone = self.mobileTextField.text;
                self.session.userEmail = self.emailTextField.text;
                [self.session save];
                NSDictionary *param2 = @{@"api_token": self.session.uniqueToken,
                                         @"name": self.nameCarTextField.text,
                                         @"license_plate": self.carmunberField.text,
                                         @"manufacture_year" : self.numberField.text,
                                         @"brand" : cardBrandID
                                         };
                [self.networkManager requestAddCarForUser:param2 comletion:^(NSDictionary *responseDict) {
                    NSError *error2;
                    AddNewCardApiJsonModel *addCarJsonModel = [[AddNewCardApiJsonModel alloc] initWithDictionary:responseDict error:&error2];
                    if ([addCarJsonModel.status intValue] == 1) {
                        NSLog(@"add car ok!");
                        self.session.carNumber = self.carmunberField.text;
                        NSString *nameCardStr = [NSString stringWithFormat:@"%@ %@",self.carbandTextField.text,self.nameCarTextField.text];
                        self.session.userCarName = nameCardStr;
                        self.session.yearOfManufactureCar = self.numberField.text;
                        [self.session save];
                        UIViewController *selfPresentView = self.presentingViewController;
                        [self dismissViewControllerAnimated:NO completion:^{
                            dispatch_async(dispatch_get_main_queue(), ^(){
                                UserVC *userVC = [[UserVC alloc]init];
                                [selfPresentView presentViewController:userVC animated:YES completion:nil];
                            });
                        }];
                    }else{
                        [[MCGlobal shareGlobal] showMessage:@"Có lỗi xảy ra trong quá trình xử lý. mời bạn thử lại." inView:self];
                    }
                }];
            }else{
                [[MCGlobal shareGlobal] showMessage:@"Có lỗi xảy ra trong quá trình xử lý. mời bạn thử lại." inView:self];
            }
        }];
    }
}
- (IBAction)donePickerButtonTap:(UIButton *)sender {
    [self.view endEditing:YES];
}

@end
