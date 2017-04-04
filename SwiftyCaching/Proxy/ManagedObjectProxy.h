//
//  ManagedObjectProxy.h
//  ManagedObjectMapper
//
//  Created by rock88 on 08/03/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagedObjectProxy<__covariant ObjectType> : NSObject

@property (nonatomic, readonly, nullable) NSString *key;

- (ObjectType)asObjectType;

@end

NS_ASSUME_NONNULL_END
