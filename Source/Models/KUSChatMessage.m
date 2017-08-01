//
//  KUSChatMessage.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSChatMessage.h"

@implementation KUSChatMessage

static KUSChatMessageDirection KUSChatMessageDirectionFromString(NSString *string)
{
    return [string isEqualToString:@"in"] ? KUSChatMessageDirectionIn : KUSChatMessageDirectionOut;
}

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"chat_message";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _trackingId = NSStringFromKeyPath(json, @"attributes.trackingId");
        _body = NSStringFromKeyPath(json, @"attributes.body");

        // TODO: ISO Date parsing
        _createdAt = nil;
        _direction = KUSChatMessageDirectionFromString(NSStringFromKeyPath(json, @"attributes.direction"));
    }
    return self;
}

- (instancetype)initWithAutoreply:(NSString *)autoreply
{
    NSDictionary *json = @{
        @"type": @"chat_message",
        @"id": @"__team",
        @"attributes": @{
            @"trackingId": @"__none",
            @"body": autoreply,
            @"direction": @"out"
        }
    };
    return [self initWithJSON:json];
}

#pragma mark - NSObject methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: oid: %@; body: %@>",
            NSStringFromClass([self class]), self, self.oid, self.body];
}

@end
