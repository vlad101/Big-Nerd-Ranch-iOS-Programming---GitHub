//
//  ItemStore.h
//  Homepwner
//
//  Created by Vladimir Efros on 6/10/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;

@interface ItemStore : NSObject
{
    NSMutableArray *allItems;
}

+ (ItemStore *)sharedStore;
- (NSArray *)allItems;
- (Item *)createItem;

@end
