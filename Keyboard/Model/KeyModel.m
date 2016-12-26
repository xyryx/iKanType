//
//  KeyModel.m
//  iKanType
//
//  Created by ಅಜೇಯ on 1/29/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

#import "KeyModel.h"

@implementation KeyboardModel

-(NSString *) getKeyboardTitle : (UIReturnKeyType) returnKeyType
{
    NSString *returnKeyText;
    
    switch (returnKeyType) {
        case UIReturnKeyDefault:
            returnKeyText = _defaultTitle;
            break;
            
        case UIReturnKeyDone:
            returnKeyText = _done;
            break;
            
        case UIReturnKeyGo:
            returnKeyText = _go;
            break;
            
        case UIReturnKeyGoogle:
            returnKeyText = _google;
            break;
            
        case UIReturnKeyJoin:
            returnKeyText = _join;
            break;
            
        case UIReturnKeyNext:
            returnKeyText = _next;
            break;
            
        case UIReturnKeyRoute:
            returnKeyText = _route;
            break;
            
        case UIReturnKeySearch:
            returnKeyText = _search;
            break;
            
        case UIReturnKeySend:
            returnKeyText = _send;
            break;
            
        case UIReturnKeyYahoo:
            returnKeyText = _yahoo;
            break;
            
        case UIReturnKeyEmergencyCall:
            returnKeyText = _emergency;
            break;
            
        case UIReturnKeyContinue:
            break;
    }
    
    return returnKeyText;
}
@end

@implementation KeyModel

-(void) setKey:(NSString *)key
{
    _key = key;
    _value = key;
}

@end
