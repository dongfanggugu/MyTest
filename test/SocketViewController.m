//
//  SocketViewController.m
//  test
//
//  Created by changhaozhang on 2017/8/21.
//  Copyright © 2017年 changhaozhang. All rights reserved.
//

#import "SocketViewController.h"
#import "GCDAsyncSocket.h"

@interface SocketViewController () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) UITextField *tfContent;

@property (nonatomic, strong) UILabel *lbContent;

@property (nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation SocketViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self connectToServer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_socket disconnect];
}

- (void)initView
{
    _lbContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    _lbContent.font = [UIFont systemFontOfSize:13];
    _lbContent.center = CGPointMake(150, 90);
    _lbContent.layer.borderColor = [UIColor blackColor].CGColor;
    _lbContent.layer.borderWidth = 1;
    [self.view addSubview:_lbContent];
    
    _tfContent = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    _tfContent.font = [UIFont systemFontOfSize:13];
    _tfContent.center = CGPointMake(150, 120);
    _tfContent.layer.borderColor = [UIColor blackColor].CGColor;
    _tfContent.layer.borderWidth = 1;
    [self.view addSubview:_tfContent];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 26)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(150, 180);
    [self.view addSubview:btn];
}

- (void)send
{
    if (0 == _tfContent.text.length)
    {
        [self showMessage:@"发送内容不能为空"];
        return;
    }
    
    NSString *content = _tfContent.text;
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:-1 tag:0];
}

- (void)showMessage:(NSString *)msg
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)connectToServer
{
    NSString *host = @"192.168.0.98";
    NSInteger port = 3000;
    
    
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error = nil;
    if (_socket.isConnected)
    {
        [_socket disconnect];
    }
    [_socket connectToHost:host onPort:port error:&error];
//    [_socket connectToUrl:[NSURL URLWithString:@"http://192.168.0.98/socket"] withTimeout:-1 error:&error];
    
    if (error)
    {
        NSLog(@"error:%@", error);
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [_socket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    sock.delegate = nil;
    sock = nil;
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@", result);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _lbContent.text = result;
    });
    
    [_socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"send successfully");
}

@end
