//
//  ItemStore.m
//  Homepwner
//
//  Created by Vladimir Efros on 6/10/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

@implementation ItemStore

+ (ItemStore *)sharedStore
{
    static ItemStore *sharedStore = nil;
    
    if(!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if(self)
        allItems = [[NSMutableArray alloc] init];
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (Item *)createItem
{
    Item *p = [Item randomItem];
    [allItems addObject:p];
    return p;
}

- (void)removeItem:(Item *)p
{
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if(from == to)
        return;
    // Get pointer to object being moved so we can re-insert it
    Item *p = [allItems objectAtIndex:from];
    
    // Remove p from array
    [allItems removeObjectAtIndex:from];
    
    // Insert p in array at new location
    [allItems insertObject:p atIndex:to];
}

@end
