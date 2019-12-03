//
//  EntryController.h
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OJCEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface OJCEntryController : NSObject


+(OJCEntryController *) shared;

@property (nonatomic, strong) NSArray *Entries;

- (instancetype)init;

- (void)addEntry:(OJCEntry *)entry;
- (void)updateEntry:(OJCEntry *)entry
          withTitle:(NSString *)title
           bodyText:(NSString *)bodyText;
- (void)removeEntry:(OJCEntry *)entry;

- (void)saveToPersistentStore;
- (void)loadFromPersistentStore;
+ (NSURL *)persistentStoreFileURL;

@end

NS_ASSUME_NONNULL_END
