//
//  Contacts.h
//  CoreData
//
//  Created by dsierra on 7/11/13.
//  Copyright (c) 2013 mexlog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Contacts : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Category *category;

@end
