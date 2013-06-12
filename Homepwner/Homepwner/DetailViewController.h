//
//  DetailViewController.h
//  Homepwner
//
//  Created by Vladimir Efros on 6/11/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface DetailViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
}
- (IBAction)backgroundTapped:(id)sender;
@property (nonatomic, strong) Item *item;
- (IBAction)takePicture:(id)sender;
@end
