//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Vladimir Efros on 6/10/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import "ItemsViewController.h"
#import "Item.h"
#import "ItemStore.h"

@implementation ItemsViewController

- (id)init
{
    // Call the superclass's designated initializer.
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        // Add 5 random items to the ItemStore
        for(int i = 0; i < 5; i++)
            [[ItemStore sharedStore] createItem];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    // Obtain the number of rows in the section.
    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of UITableView with default appearance.
    // Check for a reusable cell first, use that if it exists.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // If there is no reusable cell of this type, create a new one
    if(!cell)
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UITableViewCell"];
    
    // Set the text on the cell with the description of the item.
    // That is the nth index of items, where n = row this cell will appear in on the tableview.
    Item *p = [[[ItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[p description]];
    return cell;
}

@end
