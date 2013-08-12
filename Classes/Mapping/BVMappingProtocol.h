//
// BVMappingProtocol.h
//
//  Created by Vitalii Bogdan on 09/08/2013 .
//  Copyright (c) 2013. All rights reserved.

@protocol BVMappingProtocol <NSObject>

@required
- (NSArray *)mappingMetaData;

@optional
- (void)afterMapping:(id<BVMappingProtocol>)object;

@end