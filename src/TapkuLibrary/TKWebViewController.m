//
//  TKWebViewController.m
//  Created by Devin Ross on 5/24/13.
//
/*
 
 tapku || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */


#import "TKWebViewController.h"

@implementation TKWebViewController

- (id) initWithURL:(NSURL*)URL{
	if(!(self=[super init])) return nil;
	self.URL = URL;
	return self;
}

- (id) initWithURLRequest:(NSURLRequest*)URLRequest{
	if(!(self=[super init])) return nil;
	self.URLRequest = URLRequest;
	return self;
}

- (void) loadView{
	[super loadView];
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	self.webView.delegate = self;
	self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:self.webView];
}
- (void) viewDidLoad{
	[super viewDidLoad];
	if(self.URL)
		[self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
	else if(self.URLRequest)
		[self.webView loadRequest:self.URLRequest];
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	
	if(self.navigationController && (navigationType == UIWebViewNavigationTypeFormSubmitted || navigationType == UIWebViewNavigationTypeLinkClicked)){
		TKWebViewController *vc = [[TKWebViewController alloc] initWithURLRequest:request];
		[self.navigationController pushViewController:vc animated:YES];
		return NO;
	}
	
	return YES;
}

@end