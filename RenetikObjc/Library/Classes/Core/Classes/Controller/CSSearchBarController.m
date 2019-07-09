//
// Created by Rene Dohan on 21/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSSearchBarController.h"
#import "UIView+CSExtension.h"
#import "CSLang.h"

@implementation CSSearchBarController {
    UIViewController*_parent;
    BOOL _searchBarShouldBeginEditing;
    void (^ _onTextDidChange)(NSString*);
}

- (instancetype)init {
    super.init;
    _bar = UISearchBar.construct;
    return self;
}

- (void)loadView {
    self.view = _bar;
}

- (instancetype)construct :(CSMainController*)parent :(void (^)(NSString*))onTextDidChange {
    [super construct:parent];
    _parent = parent;
    _onTextDidChange = [onTextDidChange copy];
    _bar.delegate = self;
    return self;
}

- (void)searchBar :(UISearchBar*)searchBar textDidChange :(NSString*)searchText {
    if(!searchBar.isFirstResponder) {
        _searchBarShouldBeginEditing = NO;
        searchBar.resignFirstResponder;
    }
    runWith(_onTextDidChange, searchText);
}

- (void)searchBarCancelButtonClicked :(UISearchBar*)searchBar {
    searchBar.resignFirstResponder;
}

- (void)searchBarSearchButtonClicked :(UISearchBar*)searchBar {
    searchBar.resignFirstResponder;
}

- (BOOL)searchBarShouldBeginEditing :(UISearchBar*)bar {
    BOOL boolToReturn = _searchBarShouldBeginEditing;
    _searchBarShouldBeginEditing = YES;
    return boolToReturn;
}

- (NSString*)text {
    return _bar.text;
}

@end
