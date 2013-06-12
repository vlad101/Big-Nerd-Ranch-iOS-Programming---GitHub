//
//  ImageStore.m
//  Homepwner
//
//  Created by Vladimir Efros on 6/12/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedImageStore];
}

+ (ImageStore *)sharedImageStore
{
    static ImageStore *sharedImageStore = nil;
    if(!sharedImageStore)
        // Create the singleton
        sharedImageStore = [[super allocWithZone:NULL] init];
    return sharedImageStore;
}

- (id)init
{
    self = [super init];
    if(self)
        dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s
{
    return [dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s
{
    if(!s)
        return;
    [dictionary removeObjectForKey:s];
}

@end
