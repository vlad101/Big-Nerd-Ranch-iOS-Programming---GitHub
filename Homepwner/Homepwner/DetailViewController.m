//
//  DetailViewController.m
//  Homepwner
//
//  Created by Vladimir Efros on 6/11/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "ImageStore.h"

@implementation DetailViewController

@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set three data fields.
    [nameField setText:[item itemName]];
    [serialNumberField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    
    // Set the data, turn the date into a date string.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set dateLabel contents
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
    
    NSString *imageKey = [item imageKey];
    
    if(imageKey)
    {
        // Get image for image key from image store
        UIImage *imageToDisplay = [[ImageStore sharedImageStore] imageForKey:imageKey];
        
        // Use that image to put on the screen in imageView
        [imageView setImage:imageToDisplay];
    }
    else
        // Clear the imageView
        [imageView setImage:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    // Save changes to item
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialNumberField text]];
    [item setValueInDollars:[[valueField text] intValue]];
}

- (void)setItem:(Item *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

- (IBAction)takePicture:(id)sender
{
    NSString *oldKey = [item imageKey];
    // Did the item already have an image?
     if(oldKey)
        // Delete the old image
         [[ImageStore sharedImageStore] deleteImageForKey:oldKey];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device has a camera, take a picture, otherwise pick a photo from the photo library
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    else
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [imagePicker setDelegate:self];
    
    // Place imagepicker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Create a CFUUID object that knows how to create unique identifier strings
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    // Create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    // Use the unique ID to set our item's imageKey
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [item setImageKey:key];
    
    // Store image in the ImageStore with this key
    [[ImageStore sharedImageStore] setImage:image forKey:[item imageKey]];
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    // Put that image onto the screen in our image view
    [imageView setImage:image];
    
    // Take imagePicker off the screen
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}
@end
