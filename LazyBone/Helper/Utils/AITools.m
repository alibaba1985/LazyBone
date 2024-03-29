//
//  AITools.m
//  AITrans
//
//  Created by 王坜 on 15/7/18.
//  Copyright (c) 2015年 __ASIAINFO__. All rights reserved.
//

#import "AITools.h"
#import "LazyBone-Swift.h"

@implementation AITools


+ (AVAudioPlayer *)playAccAudio:(NSURL*) filename
{
    //初始化播放器的时候如下设置
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    if (![session setCategory:AVAudioSessionCategoryPlayback
                  withOptions:kAudioSessionProperty_AudioCategory
                        error:&setCategoryError]) {
        // handle error
    }
    
    if (![session setCategory:AVAudioSessionCategoryPlayAndRecord
                  withOptions:kAudioSessionProperty_OverrideAudioRoute
                        error:&setCategoryError]) {
        // handle error
    }
    
    
    /*
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    */
    
    NSError *playerError;
    
    NSData* data = [NSData dataWithContentsOfURL:filename] ;
    AVAudioPlayer* myPlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
    
    
    //AVAudioPlayer*  myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:filename error:&playerError];
    myPlayer.meteringEnabled = YES;
    //myPlayer.delegate = self;
    
    if (myPlayer == nil)
    {
        AIOCLog(@"ERror creating player: %@", [playerError description]);
    }
    
    // [self handleNotification:YES];
    [myPlayer prepareToPlay];
    [myPlayer play];
    return myPlayer;
}



+ (void)performBlock:(void(^)(void))block delay:(CGFloat)delay
{
    
}


+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (!hex) return nil;
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return nil;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


#pragma mark - 重置View的宽度

+ (void)resetWidth:(CGFloat)width forView:(UIView *)view
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

#pragma mark - 重置View的X
+ (void)resetOriginalX:(CGFloat)x forView:(UIView *)view
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a
{
    CGFloat sr = r/0xFF;
    CGFloat sg = g/0xFF;
    CGFloat sb = b/0xFF;
    UIColor *color = [UIColor colorWithRed:sr green:sg blue:sb alpha:a];
    return color;
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    CGFloat sr = r/0xFF;
    CGFloat sg = g/0xFF;
    CGFloat sb = b/0xFF;
    UIColor *color = [UIColor colorWithRed:sr green:sg blue:sb alpha:1];
    return color;
}


#pragma mark - Image From View

// 截取整个view
+ (UIImage*)imageFromView:(UIView*)view
{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


// 截取指定区域

+ (UIImage *)imageFromView:(UIView *)view inRect:(CGRect)rect
{
    
    CGSize s = rect.size;
    CGPoint pt = rect.origin;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-(int)pt.x, -(int)pt.y));
    [view.layer renderInContext:context];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return screenImage;
    
}




+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Animation Delay
+ (void)animationDelay:(CGFloat)delay completion:(void(^)(void))completion
{
    dispatch_time_t time_t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(time_t, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
        
    });
}


#pragma mark - 读取json文件返回string
+ (NSString *)readJsonWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    NSString *fileString = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSData *data = [fileManager contentsAtPath:path];
        if (data) {
            fileString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    
    // 去除空格和换行符
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *finalStr = [fileString stringByTrimmingCharactersInSet:whitespace];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return finalStr;
}

#pragma mark - 把图片变为灰度图
+ (UIImage *)convertImageToGrayScale:(UIImage *)image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

#pragma mark - New Fonts

+ (BOOL) fontsWithLanguageEN {
    NSString * language = [Localize currentLanguage];
    if (language != nil && [language isEqual: @"en"]) {
        return true;
    }else{
        return false;
    }
}

+ (UIFont *) myriadRegularWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-Regular" size:size];
    }else{
        return [UIFont systemFontOfSize:size ];
    }
}

+ (UIFont *) myriadBoldWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-Bold" size:size];
    }else{        
        return [UIFont boldSystemFontOfSize:size];
    }
}

+ (UIFont *) myriadLightSemiCondensedWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-LightSemiCn" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *) myriadLightSemiExtendedWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-LightSemiExt" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *) myriadSemiCondensedWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-SemiCn" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
        //return [UIFont systemFontOfSize:size * 3/4];
    }
}

+ (UIFont *) myriadBlackWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-Black" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
    }
}
+ (UIFont *) myriadLightWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-LightSemiCn" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
    }
}
+ (UIFont *) myriadSemiboldSemiCnWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-SemiboldSemiCn" size:size];
    }else{
        return [UIFont boldSystemFontOfSize:size];
    }
}


+ (UIFont *) myriadCondWithSize:(CGFloat)size
{
    if ([self fontsWithLanguageEN]) {
        return [UIFont fontWithName:@"MyriadPro-Cond" size:size];
    }else{
        return [UIFont systemFontOfSize:size];
    }
}

+ (CGFloat)displaySizeFrom1080DesignSize:(CGFloat)size
{
    CGFloat displaySize;
    UIScreen *screen = [UIScreen mainScreen];
    displaySize = size * screen.bounds.size.width / 1080;
    return displaySize;
}

+ (CGFloat)displaySizeFrom1242DesignSize:(CGFloat)size
{
    CGFloat displaySize;
    UIScreen *screen = [UIScreen mainScreen];
    displaySize = size * screen.bounds.size.width / 1242;
    return displaySize;
}


+ (CGSize)imageDisplaySizeFrom1080DesignSize:(CGSize)size
{
    
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat horizontalPixel = screen.bounds.size.width * 3;
    
    CGFloat rate = horizontalPixel / 1080;
    
    CGSize displaySize = CGSizeMake(size.width * rate, size.height * rate);
    
    return displaySize;
}

#pragma mark - 时间

+ (NSString *)enOrdinalIndicatorStringFromNumber:(NSInteger )number {
    // If number % 100 is 11, 12, or 13
    if (NSLocationInRange(number % 100, NSMakeRange(11, 3))) {
        return @"th";
    }
    
    switch (number % 10) {
        case 1:
            return @"st";
        case 2:
            return @"nd";
        case 3:
            return @"rd";
        default:
            return @"th";
    }
}


+ (NSString *)formatDateFromSeconds:(NSString *)seconds
{
    long longSeconds = seconds.doubleValue / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longSeconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger count = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    NSString *format = @"";
    
    if (count == 1 || count == 21 || count == 31) {
        format = @"MMM d'st', yyyy";
    }
    else if (count == 2 || count == 22)
    {
        format = @"MMM d'nd', yyyy";
    }
    else if (count == 3 || count == 23)
    {
        format = @"MMM d'rd', yyyy";
    }
    else
    {
        format = @"MMM d'th', yyyy";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[Localize currentLanguage]]];
    [formatter setDateFormat:format];
    NSString *formatDate = [formatter stringFromDate:date];
    
    return formatDate;
}



#pragma mark - Most Color


@end


@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
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
        return [UIColor clearColor];
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

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}






@end


@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end
