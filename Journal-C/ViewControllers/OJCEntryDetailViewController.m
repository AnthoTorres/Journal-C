//
//  OJCEntryDetailViewController.m
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import "OJCEntryDetailViewController.h"
#import "OJCEntryController.h"

@interface OJCEntryDetailViewController ()

@end

@implementation OJCEntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)updateWith:(OJCEntry *)entry {
    [self loadViewIfNeeded];
    self.entryTitleTextField.text = entry.title;
    self.entryBodyTextView.text = entry.bodyText;
    self.entry = entry;
}

- (IBAction)saveButtonTapped:(id)sender {
    
    if ([self.entryTitleTextField.text length] == 0) {
        return;
    }
    
    if (self.entry != nil) {
        [[OJCEntryController shared] updateEntry:self.entry
                                       withTitle:self.entryTitleTextField.text
                                        bodyText:self.entryBodyTextView.text];
    } else {
        OJCEntry *newEntry = [[OJCEntry alloc] initWithTitle:self.entryTitleTextField.text
                                                    bodyText:self.entryBodyTextView.text];
        [[OJCEntryController shared] addEntry:newEntry];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)clearButtonTapped:(id)sender {
    self.entryTitleTextField.text = @"";
    self.entryBodyTextView.text = @"";
}
@end
