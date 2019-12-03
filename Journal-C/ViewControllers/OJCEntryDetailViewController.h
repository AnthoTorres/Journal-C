//
//  OJCEntryDetailViewController.h
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OJCEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface OJCEntryDetailViewController : UIViewController

@property (nonatomic, strong) OJCEntry *entry;


//MARK:- Outlets
@property (weak, nonatomic) IBOutlet UITextField *entryTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *entryBodyTextView;

-(void) updateWith:(OJCEntry *)entry;


@end

NS_ASSUME_NONNULL_END
