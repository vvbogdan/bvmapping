//
// BVMappingCore.h
//
//  Created by Vitalii Bogdan on 09/08/2013 .
//  Copyright (c) 2013. All rights reserved.

@protocol BVMappingProtocol;

@interface BVMappingCore : NSObject

+ (void)setParserClass:(Class)clazz;

+ (id)applyMappingFromData:(NSData *)data onClass:(Class)clazz;

@end