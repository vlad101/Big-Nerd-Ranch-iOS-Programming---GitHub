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
        /*
        Chapter 9: Add 5 random items to the ItemStore
        for(int i = 0; i < 5; i++)
            [[ItemStore sharedStore] createItem];
        */
        
        // Set the tile to Homepwner
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Homepwner"];
        
        // Create a new bar button item that will send addNewItem: to ItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        // Set this bar button item as the right item in the navigation item
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        // Set this bar button item as the left item in the navigation item
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
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

// Load the headerView
- (UIView *)headerView
{
    // if the headerView is not loaded yet
    if(!headerView)
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    return headerView;
}

// Two methods set headevView as the header view of the table.

/*
 
 Chapter 9 - the following three methods are replaced with UINavigationBar
 
- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // The height of the header view should be determined from the height of the view in the XIB file.
    return [[self headerView] bounds].size.height;
}

- (void)toggleEdittingMode:(id)sender
{
    // If we are currently in editing mode
    if([self isEditing])
    {
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    }
    else
    {
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}
 */

- (IBAction)addNewItem:(id)sender
{
    // Create a new Item and add it to the store
    Item *newItem = [[ItemStore sharedStore] createItem];
    
    // Figure out where that item is in the array
    int lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into the table.
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationTop];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        ItemStore *ps = [ItemStore sharedStore];
        NSArray *items = [ps allItems];
        Item *p = [items objectAtIndex:[indexPath row]];
        [ps removeItem:p];
        // Remove the row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
       toIndexPath:(NSIndexPath *)toIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:[fromIndexPath row] toIndex:[toIndexPath row]];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set DetailViewController to have an item before viewWillAppear gets called
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *selectedItem = [items objectAtIndex:[indexPath row]];
    
    // Give detail view controller a pointer to the view object in row
    [detailViewController setItem:selectedItem];
    
    // Push it into the top of the navigation controller's stack
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

@end
