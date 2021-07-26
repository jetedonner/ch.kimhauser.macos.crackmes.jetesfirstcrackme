//
//  ViewController.h
//  JetesFirstCrackme
//
//  Created by Kim David Hauser on 24.07.21.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

extern NSString *dateString;

@property (nonatomic, weak) IBOutlet NSButton *btnCheck;
@property (nonatomic, weak) IBOutlet NSTextField *lblResult;

@property (nonatomic) IBOutlet NSTextView *txtLicense;
@property (nonatomic, weak) IBOutlet NSTextField *txtName;

- (void)logMsg2Output: (NSString*)msg;
- (void)licenseIs: (BOOL)isValid;
+ (NSString*)decodeStringTo64:(NSString*)fromString;
+ (NSString *) stringToHex:(NSString *)str;
@end

