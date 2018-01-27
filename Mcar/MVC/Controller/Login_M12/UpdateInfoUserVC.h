//
//  UpdateInfoUserVC.h
//  Mcar
//
//  Created by thanh tung on 10/27/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserJsonModel.h"
#import "MCBaseVC.h"
#import "UpdateInfoUserApiJsonModel.h"
#import "AddNewCardApiJsonModel.h"
#import "UserVC.h"
#import "ApiCarBrandJsonModel.h"

@interface UpdateInfoUserVC : MCBaseVC<UIPickerViewDelegate,UIPickerViewDataSource>
@property(strong,nonatomic) UserJsonModel *userJsonModel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameCarTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *carmunberField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *carbandTextField;
@property (strong,nonatomic) NSArray *arrData;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIView *inputPickerView;

@end
