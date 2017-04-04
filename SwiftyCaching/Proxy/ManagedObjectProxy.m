//
//  ManagedObjectProxy.m
//  ManagedObjectMapper
//
//  Created by rock88 on 08/03/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

#import "ManagedObjectProxy.h"

@implementation ManagedObjectProxy

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    _key = NSStringFromSelector(aSelector);
    return [super methodSignatureForSelector:@selector(description)];
}

- (id)asObjectType {
    _key = nil;
    return self;
}

@end
