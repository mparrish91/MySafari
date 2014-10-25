//
//  ViewController.m
//  MySafari
//
//  Created by malcolm on 10/19/14.
//  Copyright (c) 2014 parry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UILabel *webPageTitleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.webView.canGoBack) {
        [self.backButton setEnabled:YES];
    }else{
        [self.backButton setEnabled:NO];
    }
    
    if (self.webView.canGoForward) {
        [self.forwardButton setEnabled:YES];
    }else{
        [self.forwardButton setEnabled:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self loadWebPage:textField.text];
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    self.urlTextField.text = [[webView.request URL]absoluteString];
    self.webPageTitleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (IBAction)onBackButtonPressed:(id)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [sender setEnabled:NO];
    }
}
- (IBAction)onPlusButtonPressed:(id)sender {

    UIAlertView *comingSoon = [[UIAlertView alloc]init];
    comingSoon.delegate = self;
    comingSoon.message = @"Coming soon!";
    [comingSoon addButtonWithTitle:@"Go Home"];
    [comingSoon show];
    
    
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}


- (void)loadWebPage:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest;
    
    if ([self.urlTextField.text rangeOfString:@"http://" options:NSAnchoredSearch].location == NSNotFound) {
        NSString *urlWithHttpAdded = [@"http://" stringByAppendingString:self.urlTextField.text];
        url = [NSURL URLWithString:urlWithHttpAdded];
    }
    urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.urlTextField.alpha = 0.5;
    self.urlTextField.hidden = YES;
    

    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0) {
        self.urlTextField.hidden = NO;

    }else if (scrollOffset + scrollViewHeight ==scrollContentSizeHeight){
        
    }
    

}

@end
