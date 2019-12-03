//
//  EntryController.m
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import "OJCEntryController.h"

@implementation OJCEntryController

+ (OJCEntryController *) shared {
    static OJCEntryController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [OJCEntryController new];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _Entries = [NSArray<OJCEntry *> new];
        [self loadFromPersistentStore];
    }
    
    return self;
}

- (void)addEntry:(OJCEntry *)entry {
    self.Entries = [self.Entries arrayByAddingObject:entry];
    [self saveToPersistentStore];
}

- (void)updateEntry:(OJCEntry *)entry withTitle:(NSString *)title bodyText:(NSString *)bodyText {
    entry.title = title;
    entry.bodyText = bodyText;
    entry.timeStamp = [NSDate new];
    [self saveToPersistentStore];
}

- (void)removeEntry:(OJCEntry *)entry {
    NSMutableArray *mutableEntries = [self.Entries mutableCopy];
    [mutableEntries removeObject:entry];
    self.Entries = mutableEntries;
    [self saveToPersistentStore];
}

- (void)saveToPersistentStore {
    
    NSMutableArray *entriesToSave = [NSMutableArray<NSDictionary *> new];
    
    for (OJCEntry *entry in self.Entries) {
        [entriesToSave addObject:[entry dictionaryCopy]];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:entriesToSave
                                                       options:kNilOptions
                                                         error:&error];
    if (error) {
        NSLog(@"Unable to convert entries to JSON: %@", error);
        return;
    }
    
    NSURL *url = [OJCEntryController persistentStoreFileURL];
    [jsonData writeToURL:url atomically:YES];
}

- (void)loadFromPersistentStore {
    NSURL *url = [OJCEntryController persistentStoreFileURL];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL:url options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error loading JSON data from file: %@", error);
        return;
    }
    
    NSArray *rawEntries = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error converting JSON data to NSObject: %@", error);
        return;
    }
    
    NSMutableArray *newEntries = [NSMutableArray new];
    
    for (NSDictionary *entryDict in rawEntries) {
        OJCEntry *entry = [[OJCEntry alloc] initWithDictionary:entryDict];
        
        if (entry) {
            [newEntries addObject:entry];
        }
    }
    
    self.Entries = [newEntries copy];
}

+ (NSURL *)persistentStoreFileURL {
    NSArray<NSURL *> *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                    inDomains:NSUserDomainMask];
    return [urls[0] URLByAppendingPathComponent:@"journal.json"];
}



@end
