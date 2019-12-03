//
//  Entry.m
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import "OJCEntry.h"

@implementation OJCEntry

static NSString *const TimestampKey = @"timestamp";
static NSString *const TitleKey = @"title";
static NSString *const BodyTextKey = @"bodyText";

- (instancetype)initWithTitle:(NSString *)title bodyText:(NSString *)bodyText
                    timeStamp:(NSDate *)timeStamp

{
    self = [super init];
    
    if (self != nil) {
        
        _title = title;
        _bodyText = bodyText;
        _timeStamp = timeStamp;
    }
    return self;
}

-(instancetype) initWithTitle:(NSString *)title bodyText:(NSString *)bodyText
{
    return [self initWithTitle:title bodyText:bodyText timeStamp:[NSDate new]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (dictionary[TitleKey] == nil || dictionary[BodyTextKey] == nil || dictionary[TimestampKey] == nil) {
        return nil;
    }
    
    if (self) {
        _title = dictionary[TitleKey];
        _bodyText = dictionary[BodyTextKey];
        NSTimeInterval timeInterval = [dictionary[TimestampKey] doubleValue];
        _timeStamp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    
    return self;
}

- (NSDictionary *)dictionaryCopy {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    dict[TitleKey] = self.title;
    dict[BodyTextKey] = self.bodyText;
    dict[TimestampKey] = [NSNumber numberWithFloat:[self.timeStamp timeIntervalSince1970]];
    
    return [dict copy];
}

@end
