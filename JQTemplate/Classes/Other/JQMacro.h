//
//  JQMacro.h
//  JQTemplate
//
//  Created by JackieQu on 2023/5/30.
//

#ifndef JQMacro_h
#define JQMacro_h

#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height

#define SAFE_TOP                    [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top
#define SAFE_BOTTOM                 [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom

#define STATUS_BAR_HEIGHT           SAFE_TOP
#define NAV_BAR_HEIGHT              44.f
#define TAB_BAR_HEIGHT              (49.f + SAFE_BOTTOM)
#define STATUS_NAV_HEIGHT           (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)

#define CONTENT_HEIGHT              (SCREEN_HEIGHT - STATUS_NAV_HEIGHT - TAB_BAR_HEIGHT)
#define CONTENT_TAB_HEIGHT          (SCREEN_HEIGHT - STATUS_NAV_HEIGHT)

#define STANDARD_MARGIN             20.f
#define STANDARD_PADDING            20.f
#define STANDARD_WIDTH              375.f
#define STANDARD_HEIGHT             667.f

#define ADAPT_SCALE                 (SCREEN_WIDTH / STANDARD_WIDTH)
#define ADAPT_VALUE(v)              roundf(v * ADAPT_SCALE)

#define ADAPT_SCALE_HORIZONTAL      (SCREEN_WIDTH / STANDARD_HEIGHT)
#define ADAPT_VALUE_HORIZONTAL(v)   roundf(v * ADAPT_SCALE_HORIZONTAL)

#endif /* JQMacro_h */

#ifdef DEBUG

#define JQLog(s, ...)               NSLog(@"<%@: %d> %@",  \
                                            [[NSString stringWithUTF8String:__FILE__] lastPathComponent],   \
                                            __LINE__,   \
                                            [NSString stringWithFormat:(s), ##__VA_ARGS__]);
#define JQLogFunction               JQLog(@"%s", __FUNCTION__);

#else

#define JQLog(s, ...)
#define JQLogFunction

#endif
