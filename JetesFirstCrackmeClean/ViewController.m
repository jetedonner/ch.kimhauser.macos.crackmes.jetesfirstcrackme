//
//  ViewController.m
//  JetesFirstCrackme
//
//  Created by Kim David Hauser on 24.07.21.
//

#import "ViewController.h"

@implementation ViewController

NSString *dateString =  @"2021-07-24";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)logMsg2Output: (NSString*)msg{
    _txtLicense.string = [NSString stringWithFormat:@"%@\n%@", _txtLicense.string, msg];
    [_txtLicense scrollRangeToVisible: NSMakeRange(_txtLicense.string.length, 0)];
}

+ (NSString*)decodeStringTo64:(NSString*)fromString
{
    NSMutableString * newString = [[NSMutableString alloc] init];
    int i = 0;
    while (i < [fromString length])
    {
        NSString * hexChar = [fromString substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
        i+=2;
    }
    return newString;
}

- (IBAction)buttonPressed:(id)sender {
    
    NSString *base64 = _txtLicense.string;
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64 options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    NSString *hexDecoded = [ViewController decodeStringTo64:decodedString];
    if([hexDecoded hasPrefix: _txtName.stringValue]){
        NSString *subStr1 = [hexDecoded substringFromIndex:_txtName.stringValue.length];
        NSString *subStr2 = [subStr1 substringToIndex:10];
        NSString *subStr3 = [subStr1 substringFromIndex:subStr2.length];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:subStr2];
        
        if(date != nil){
            if([subStr2 isEqualToString:dateString]){
                long daLen = _txtName.stringValue.length + 0xa;
                NSString *subStr4 = [NSString stringWithString: subStr3];
                bool hasError = false;
                for (int i = 0; i < daLen * 2; i++) {
                    NSString *currPart = @"";
                    if(i % 2 == 0){
                        currPart = [NSString stringWithFormat:@"%d", i];
                    }else{
                        currPart = [NSString stringWithFormat:@"%c", i + 0x40];
                    }
                    if([subStr4 hasPrefix:currPart]){
                    }else{
                        hasError = true;
                        break;
                    }
                    subStr4 = [subStr4 substringFromIndex:currPart.length];
                }
                if(!hasError){
                    [self licenseIs:true];
                }else{
                    [self licenseIs:false];
                }
            }else{
                [self licenseIs:false];
            }
        }else{
            [self licenseIs:false];
        }
    }else{
        [self licenseIs:false];
    }
}

- (void)licenseIs: (BOOL)isValid{
    if(isValid){
        _lblResult.backgroundColor = NSColor.greenColor;
        _lblResult.stringValue = @"License IS VALID";
    }else{
        _lblResult.backgroundColor = NSColor.redColor;
        _lblResult.stringValue = @"License is NOT VALID";
    }
}

+ (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];

    NSMutableString *hexString = [[NSMutableString alloc] init];

    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    return hexString;
}
@end
