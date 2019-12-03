//
//  Entry.h
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OJCEntry : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *bodyText;
@property (nonatomic, strong) NSDate *timeStamp;

-(instancetype) initWithTitle: (NSString *)title
                     bodyText:(NSString *)bodyText
                    timeStamp:(NSDate *)timeStamp;

-(instancetype) initWithTitle:(NSString *)title
                     bodyText:(NSString *)bodyText;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryCopy;

@end

NS_ASSUME_NONNULL_END
