//
// BVMappingArray.h
//
//  Created by Vitalii Bogdan on 12/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingObject.h"

@interface BVMappingArray : BVMappingObject

@property (nonatomic, strong) NSString * itemClass;
@property (nonatomic, strong) NSString * parentKey;

+ (id)key:(NSString *)key property:(NSString *)property itemClass:(NSString *)itemClass;
+ (id)key:(NSString *)key parentKey:(NSString *)parentKey property:(NSString *)property itemClass:(NSString *)itemClass;

@end