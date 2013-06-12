//
//  ImageStore.h
//  Homepwner
//
//  Created by Vladimir Efros on 6/12/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;

@interface ImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (ImageStore *) sharedImageStore;
- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
