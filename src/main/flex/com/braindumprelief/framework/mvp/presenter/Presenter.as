package com.braindumprelief.framework.mvp.presenter {

import flash.events.IEventDispatcher;

public interface Presenter extends IEventDispatcher {
	/**
	 * The view managed by a Presenter.
	 */
	function get view():Object;
	function set view( value:Object ):void;
}
}
