//
// BVMappingParseProtocol.h
//
//  Created by Vitalii Bogdan on 12/08/2013 .
//  Copyright (c) 2013. All rights reserved.

@class BVMappingObject;

@protocol BVMappingParseProtocol <NSObject>

@required
- (NSObject *)documentWithData:(NSData *)data error:(NSError **)error;
- (NSString *)valueStringWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject;
- (NSObject *)valueObjectWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject;
- (NSArray *)arrayWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject;

@optional
- (NSObject *)rootObjectWithDocumentObject:(NSObject *)document;

@end