//
//  CoreDataViewController.h
//  CoreData
//
//  Created by dsierra on 7/11/13.
//  Copyright (c) 2013 mexlog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *categoryField;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)saveContact:(id)sender;

- (IBAction)findContact:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
