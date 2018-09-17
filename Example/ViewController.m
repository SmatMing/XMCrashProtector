//
//  ViewController.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/8/16.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "ViewController.h"
#import "XMProtectorManager.h"
#import "TestKVOModel.h"

@interface ViewController ()
@property (nonatomic, strong) TestKVOModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XMProtectorManager openAllCrashProtectorWithBlock:^(NSException *exception, NSString *crashLog, XMCrashProtectorType crashType) {
        NSLog(@"");
    }];
    //注意：如需测试请把注释代码放出即可
    //[self startTest];
}

- (void)startTest {
    [self testArray];
    [self testMutableArray];
    
    [self testDict];
    [self testMutableDict];
    
    [self testString];
    [self testMutableString];
    
    [self testAttributedString];
    [self testMutableAttributedString];

    [self testUnrecognizedSelector];
    
    [self testKVO];
    
    [self testNotifactionCenter];
    
}

#pragma mark - -------------------------NSArray-------------------------
- (void)testArray {
    //1.
    NSString *nilStr = nil;
    NSArray *array1 = @[@"11111", nilStr, @"22222"];
    NSLog(@"%@",array1);
    
    //2.
    NSArray *array2 = @[@"33333", @"444444"];
    id object = array2[100];
    NSLog(@"object = %@",object);
    
    //3.
    NSArray *array3 = @[@"55555"];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:100];
    [array3 objectsAtIndexes:indexSet];
    
    //4.
    NSArray *array4 = @[@"66666", @"77777", @"88888"];
    NSRange range = NSMakeRange(0, 15);
    __unsafe_unretained id cArray[range.length];
    [array4 getObjects:cArray range:range];
}

- (void)testMutableArray {
    //1.
    NSMutableArray *array1 = @[@"9999999"].mutableCopy;
    NSObject *object = array1[10];
    NSLog(@"object = %@",object);
    
    //2.
    NSMutableArray *array2 = @[@"10101010"].mutableCopy;
    array2[10] = @"XMXM";
    
    //3.
    NSMutableArray *array3 = @[@"11111111", @"12121212"].mutableCopy;
    [array3 removeObjectAtIndex:10];
    
    //4.
    NSMutableArray *array4 = @[@"13131313"].mutableCopy;
    [array4 insertObject:@"PPPPPPP" atIndex:10];
    
    //5.
    NSMutableArray *array5 = @[@"14141414", @"15151515"].mutableCopy;
    NSRange range = NSMakeRange(0, 10);
    __unsafe_unretained id cArray[range.length];
    [array5 getObjects:cArray range:range];
}

#pragma mark - -------------------------NSDictionary-------------------------
- (void)testDict {
    //1.
    NSString *nilStr = nil;
    NSDictionary *dict = @{
                           @"name" : @"xm",
                           @"age" : nilStr
                           };
    NSLog(@"dict=%@",dict);
}

- (void)testMutableDict {
    //1.
    NSMutableDictionary *dict1 = @{
                                  @"name" : @"xm",
                                  @"age"  : [NSNull null],
                                  }.mutableCopy;
    NSString *ageKey = nil;
    dict1[ageKey] = @(25);
    NSLog(@"muDict=%@",dict1);
    
    //2.
    NSMutableDictionary *dict2 = @{
                                  @"name" : @"xm",
                                  @"age" : @(25)
                                  
                                  }.mutableCopy;
    NSString *key = nil;
    [dict2 removeObjectForKey:key];
}

#pragma mark - -------------------------NSString-------------------------
- (void)testString {
    //1.
 /*   NSString *str1 = @"aaaaaaaaaaaa";
    unichar characteristic = [str1 characterAtIndex:100];
    
    //2.
    NSString *str2 = @"bbbbbbbbbbbb";
    NSString *fromStr = [str2 substringFromIndex:100];
    
    //3.
    NSString *str3 = @"ccccccccccc";
    NSString *toStr = [str3 substringToIndex:100];
    
    //4.
    NSString *str4 = @"ddddddddddd";
    NSRange range = NSMakeRange(0, 100);
    NSString *rangbStr = [str4 substringWithRange:range];
    
    //5.
    NSString *nilStr = nil;
    NSString *str6 = @"eeeeeeeeeee";
    str6 = [str6 stringByReplacingOccurrencesOfString:nilStr withString:nilStr];
    
    //6.
    NSString *str7 = @"ffffffffffff";
    str7 = [str7 stringByReplacingOccurrencesOfString:@"?????" withString:@"" options:NSCaseInsensitiveSearch range:range];
    
    //7.
    NSString *str8 = @"gggggggggggggg";
    NSRange range1 = NSMakeRange(0, 1000);
    str8 = [str8 stringByReplacingCharactersInRange:range1 withString:@"#####"];
  */
}

- (void)testMutableString {
    //1.
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"hhhhhhhhhhh"];
    NSRange range = NSMakeRange(0, 1000);
    [str1 replaceCharactersInRange:range withString:@"*******"];
    
    //2.
    NSMutableString *str2 = [NSMutableString stringWithFormat:@"iiiiiiiiiiii"];
    [str2 insertString:@"&&&&&&&&" atIndex:1000];
    
    //3.
    NSMutableString *str3 = [NSMutableString stringWithFormat:@"jjjjjjjjjjjjj"];
    NSRange range1 = NSMakeRange(0, 1000);
    [str3 deleteCharactersInRange:range1];
    
}

#pragma mark - -------------------------NSAttributedString-------------------------
- (void)testAttributedString {
    //1.
   /* NSString *str1 = nil;
    NSAttributedString *attributeStr1 = [[NSAttributedString alloc] initWithString:str1];
    
    //2.
    NSAttributedString *nilAttributedStr = nil;
    NSAttributedString *attributedStr2 = [[NSAttributedString alloc] initWithAttributedString:nilAttributedStr];
    
    //3.
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSString *nilStr = nil;
    NSAttributedString *attributedSt3 = [[NSAttributedString alloc] initWithString:nilStr attributes:attributes];
    */
}

- (void)testMutableAttributedString {
    //1.
  /*  NSString *nilStr = nil;
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:nilStr];
    
    //2.
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSString *nilStr1 = nil;
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:nilStr1 attributes:attributes];
   */
}

#pragma mark - -------------------------KVC-----------------------
- (void)testKVO {
    //1.nil
    TestKVOModel *model1 = [[TestKVOModel alloc] init];
    self.model = model1;
//    [self addObserver:nil forKeyPath:@"111111" options:(NSKeyValueObservingOptionNew) context:nil];
//    [self addObserver:self.model forKeyPath:nil options:(NSKeyValueObservingOptionNew) context:nil];
    
    //2.重复移除
    TestKVOModel *model2 = [[TestKVOModel alloc] init];
    self.model = model2;
    [self addObserver:self.model forKeyPath:@"kvoRemove" options:(NSKeyValueObservingOptionNew) context:nil];
    [self removeObserver:self.model forKeyPath:@"kvoRemove"];
    [self removeObserver:self.model forKeyPath:@"kvoRemove" context:nil];
    
    //3.重复添加,
    TestKVOModel *model3 = [[TestKVOModel alloc] init];
    self.model = model3;
    [self addObserver:self.model forKeyPath:@"repeatAddkvo" options:(NSKeyValueObservingOptionNew) context:nil];
    [self addObserver:self.model forKeyPath:@"repeatAddkvo" options:(NSKeyValueObservingOptionNew) context:nil];
    
    //4.dealloc时没有移除obverser
    TestKVOModel *model4 = [[TestKVOModel alloc] init];
    model4.testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.model = model4;
    [self.view addSubview:model4.testView];
    [self addObserver:self.model.testView forKeyPath:@"deallockvo" options:(NSKeyValueObservingOptionNew) context:nil];
    
    [model4.testView removeFromSuperview];
    self.model = nil;
    
}


#pragma mark - ------------------NotifactionCenter---------------------
- (void)testNotifactionCenter {
    //ios9 一直就不会crash了
    TestKVOModel *model = [[TestKVOModel alloc] init];
    model.testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.model = model;
    [self.view addSubview:model.testView];
//    [[NSNotificationCenter defaultCenter] addObserver:self.model.testView selector:@selector(notifiaction:) name:@"notifiaction" object:nil];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"notifiaction" object:nil];
    
    [model.testView removeFromSuperview];
    model.testView = nil;
    
    self.model = nil;
}




#pragma mark - ---------------unrecognized selector sent to instance------------------
- (void)testUnrecognizedSelector {
    
    //    [self performSelector:@selector(actonstart1) withObject:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
