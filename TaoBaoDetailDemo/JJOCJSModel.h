//
//  JJOCJSModel.h
//  TaoBaoDetailDemo
//
//  Created by vpjacob on 2017/6/2.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSExport.h>

@protocol JJOCJSModelProtocol <JSExport>

JSExportAs(nslog, -(void)print:(NSString *)string);

@end

typedef void(^JJOCJSModelBlock)(NSString *str);

@interface JJOCJSModel : NSObject<JJOCJSModelProtocol>
@property (nonatomic, copy)JJOCJSModelBlock myBlock;
@end
