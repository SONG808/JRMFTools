//
//  JYangTools.h
//  JYangToolKit
//
//  Created by 金阳 on 16/3/18.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "JYangTools.h"
#define kSYSTEM_OS          [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation JYangTools
//* 获取规定文字在规定范围的Size
+ (CGSize)getSize:(NSString *)text sizeBy:(CGSize)size font:(UIFont *)font {
    NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            font,
                            NSFontAttributeName,
                            nil];
    CGRect rect = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil];
    return rect.size;
}

//* 获取字符串末4位数
+(NSString *)getLastForthStringFromString:(NSString *)sourceString {
    if (sourceString == nil || sourceString.length <= 4) {
        NSLog(@"获取银行卡末4位数，卡号信息错误");
        return @"";
    }
    
    return [sourceString substringFromIndex:sourceString.length-4];
}

//定义函数，进行对应的网络地址的汉字转换操作
+(NSString *)getFormatURLFromString:(NSString *)dataString {
    //对传入的数据进行对应的验空操作处理
    if(dataString == nil||dataString.length==0)
    {
        //        xh(@"进行对应请求网址转化时传入的对应网络地址为空，请检查输入！");
        return @"";
    }
    
    //将对应的原始url转化为cfstring
    CFStringRef originalURL=(__bridge CFStringRef)dataString;
    //将对应的汉字转化为对应的空字符串并进行对应的替代操作
    CFStringRef preProcessedString=CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, originalURL,CFSTR(""), kCFStringEncodingUTF8);
    //用对应的空位符进行对应的字符串的替代处理操作
    CFStringRef processedString=CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, preProcessedString, NULL, NULL, kCFStringEncodingUTF8);
    //获得对应的url变量
    CFURLRef url=CFURLCreateWithString(kCFAllocatorDefault, processedString, NULL);
    
    
    //将对应的url转化为对应的nsurl对象
    //    NSString *resultString = (__bridge NSString*)url;
    NSString *resultString =(__bridge_transfer NSString*)url;
    
    
    //将对应的nsurl对象转化为对应的nsstring对象
    if([resultString isKindOfClass:[NSURL class]])
    {
        NSURL* tempURL=(__bridge NSURL*)url;
        resultString=[tempURL absoluteString];
    }
    
    CFRelease(processedString);
    //将对应的结果进行返回操作
    return resultString;
}

#pragma mark - 身份证号校验
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }
    else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray * areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString * valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString * areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch > 0) {
                return YES;
            }
            else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }
            else {
                return NO;
            }
        default:
            return false;
    }
}

#pragma mark - 判断银行卡合法性
+ (BOOL)CheckCardNumberInput:(NSString *)_text {
    
    NSString *Regex = @"^(\\d{16}|\\d{19})$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [emailTest evaluateWithObject:_text];
}

#pragma mark - Alert 弹框
+ (void)showAlertViewWithMsg:(NSString*)msg presentVC:(UIViewController *)presentVC {
    if (kSYSTEM_OS < 8.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedStringFromTable(@"确定", @"JrmfInfo", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"确定", @"JrmfInfo", nil) style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [presentVC presentViewController:alertController animated:YES completion:nil];
    }
    
}

+ (void)showAlertView:(UIViewController *)viewController message:(NSString *)msg leftTxt:(NSString *)lTxt leftHandler:(void (^)())leftHandler rightTxt:(NSString *)rTxt rightHandler:(void (^)())rightHandler tag:(NSInteger)tag {
    if (kSYSTEM_OS < 8.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:msg
                                                           delegate:viewController
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:lTxt, rTxt, nil];
        alertView.tag = tag;
        [alertView show];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * leftAction = [UIAlertAction actionWithTitle:lTxt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(leftHandler) {
                leftHandler();
            }
        }];
        UIAlertAction * rightAction = [UIAlertAction actionWithTitle:rTxt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightHandler) {
                rightHandler();
            }
        }];
        [alertController addAction:leftAction];
        [alertController addAction:rightAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

+ (void)showAlertViewWithMsg:(NSString*)msg alertViewDelegate:(UIViewController *)delegate btnTxt:(NSString *)btntxt handler:(void (^)())handler tag:(NSInteger)tag {
    if (kSYSTEM_OS < 8.0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:msg
                                                           delegate:delegate
                                                  cancelButtonTitle:btntxt
                                                  otherButtonTitles:nil];
        alertView.tag = tag;
        [alertView show];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * leftAction = [UIAlertAction actionWithTitle:btntxt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler();
        }];
        [alertController addAction:leftAction];
        [delegate presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 判断手机号合法性
+(BOOL)CheckPhoneInput:(NSString *)_text {
    
    NSString *Regex = @"^0?(13|15|18|14|17)[0-9]{9}$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [emailTest evaluateWithObject:_text];
    
}

#pragma mark - 判空
+ (BOOL)CheckEmptyWithString:(NSString *)string {
    BOOL ret = YES;
    if (string == nil) {
        return ret;
    }
    if (string.length == 0) {
        return ret;
    }
    
    ret = NO;
    return ret;
}

#pragma mark - 隐藏身份证号码
+ (NSString *)getIDCardNumberHideFromString:(NSString *)sourceString {
    if (![JYangTools validateIDCardNumber:sourceString]) {
        return sourceString;
    }
    
    NSString * string = [NSString stringWithFormat:@"%@******%@", [sourceString substringToIndex:6], [sourceString substringFromIndex:14]];
    return string;
}

#pragma mark - 获取时间戳
+ (NSString *)getCurTimeLong {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (NSString *)getCurTimeDateWithTimeStemp:(NSString *)stemp {
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[stemp floatValue]];

//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyyMMddHHMMss"];
//    NSDate *date = [formatter dateFromString:stemp];
//    NSLog(@"date1:%@",date);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stemp floatValue] / 1000];
    NSString *dateString = [formatter stringFromDate:date];

    
    return dateString;
}

#pragma mark - 时间戳确定1min的间隔
+ (NSInteger)isTimeStempForOneMinutes:(NSString *)string {
    //取当前时间的秒数
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
//    NSLog(@"当前时间date = %lld", date);
    
    //#warning - msg
    long long int distance = 60;
    
    long long int disdate = [string integerValue];
//    NSLog(@"date = %lld, disdate = %lld, distance = %lld, (distance + disdate) = %lld", date , disdate, distance, (distance + disdate));
    
    NSInteger result = (NSInteger)((disdate + distance) - date);
    return result;
//    if (date > (distance + disdate)) {
//        return YES;
//    }
//
//    return NO;
}

#pragma mark - 从bundle中读取图片
+(UIImage*) imagesNamedFromCustomBundle:(NSString *)name {
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"JResource.bundle/"];
    //    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    NSString *image_path = [main_images_dir_path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    return [UIImage imageWithContentsOfFile:image_path];
}

+ (UIImage*)imagesNamedFromCustomBundle:(NSString *)bundle imgName:(NSString *)name {
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", bundle]];
    //    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    NSString *image_path = [main_images_dir_path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    return [UIImage imageWithContentsOfFile:image_path];
}


#pragma mark - 将电话号码中间隐藏
+ (NSString *)getPhoneNumberHideFromString:(NSString *)sourceString {
    if (![JYangTools CheckPhoneInput:sourceString]) {
        return sourceString;
    }
    
    NSString * string = [NSString stringWithFormat:@"%@****%@", [sourceString substringToIndex:3], [sourceString substringFromIndex:7]];
    return string;
}

#pragma mark - 16进制制色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha defaultColor:(UIColor *)defaultColor {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return defaultColor;
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return defaultColor;
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - base64编码
+ (NSString *)stringByBase64Encode:(NSString *)string {
    NSData * baseData = [string dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString * encodeResult = [baseData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return encodeResult;
}

#pragma mark - base64解码
+ (NSString *)stringByBase64Decode:(NSString *)string {
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedString:string options:0];

    NSString * decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    
    return decodeStr;
}

#pragma mark - 银行卡简单格式校验
+ (BOOL)checkBankCardNo:(NSString*)cardNo{
    if (cardNo.length == 0) {
        NSLog(@"银行卡格式错误");
        return NO;
    }
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma mark - 颜色生成图片
+ (UIImage *) createImageWithColor: (UIColor *) color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

#pragma mark - 去除字符串首尾空格
+ (NSString *)TrimmingSpaceCharacterWithString:(NSString *)string {
    if (string.length == 0) {
        return @"";
    }
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


@end
