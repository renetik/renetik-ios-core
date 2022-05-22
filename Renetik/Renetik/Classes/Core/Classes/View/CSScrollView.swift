//
// Created by Rene Dohan on 12/22/19.
//

import UIKit
import TPKeyboardAvoiding

open class CSScrollView: TPKeyboardAvoidingScrollView {

	@discardableResult
	public class func construct() -> Self { construct(defaultSize: true) }

	@discardableResult
	public class func construct(_ function: ArgFunc<CSScrollView>) -> Self {
		let _self = construct(defaultSize: true)
		function(_self)
		return _self
	}

//    public let layoutFunctions: CSEvent<Void> = event()
//	public let eventLayoutSubviewsFirstTime: CSEvent<Void> = event()

//	@discardableResult
//	public func layout(function: @escaping Func) -> Self {
//		layoutFunctions.listen { function() }
//		function()
//		return self
//	}

//	private var isDidLayoutSubviews = false

	override open func layoutSubviews() {
		super.layoutSubviews()
		onLayoutSubviews()
	}

	@discardableResult
	override public func updateLayout() -> Self { animate { self.layoutFunctions.fire() }; return self }
}
