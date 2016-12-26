//
//  KeyModel.h
//  iKanType
//
//  Created by ಅಜೇಯ on 1/29/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@protocol KeyModel
@end

@interface KeyboardModel : JSONModel

@property (nonatomic, strong) NSString* language;

@property (nonatomic, assign) CGFloat keyFontSize;
@property (nonatomic, assign) CGFloat commandFontSize;

@property (atomic, retain) NSString *space;
@property (atomic, retain) NSString *alphaKeyTitle;
@property (atomic, retain) NSString *punctuationKeyTitle;
@property (atomic, retain) NSString *numericKeyTitle;

@property (atomic, retain) NSString *emergency;
@property (atomic, retain) NSString *yahoo;
@property (atomic, retain) NSString *search;
@property (atomic, retain) NSString *send;
@property (atomic, retain) NSString *next;
@property (atomic, retain) NSString *route;
@property (atomic, retain) NSString *go;
@property (atomic, retain) NSString *google;
@property (atomic, retain) NSString *join;
@property (atomic, retain) NSString *done;
@property (atomic, retain) NSString *defaultTitle;

@property (nonatomic, strong) NSArray<KeyModel>* alpha;
@property (nonatomic, strong) NSArray<KeyModel>* shift;
@property (nonatomic, strong) NSArray<KeyModel>* numeric;
@property (nonatomic, strong) NSArray<KeyModel>* punctuations;

-(NSString *) getKeyboardTitle : (UIReturnKeyType) returnKeyType;

@end

@interface KeyModel : JSONModel

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString<Optional>* diacritic;
@property (nonatomic, strong) NSString<Optional>* value;

@end
