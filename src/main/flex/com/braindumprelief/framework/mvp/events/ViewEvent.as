package com.braindumprelief.framework.mvp.events {

import flash.display.DisplayObject;
import flash.events.Event;

import mx.core.IVisualElement;

/**
 * A ViewEvent is the base event dispatched by all views
 * in the framework.
 */
public class ViewEvent extends Event {
	
	public static const PREINITIALIZE:String = "frameworkPreinitialize";
	public static const INITIALIZE:String = "frameworkInitialize";
	public static const CREATION_COMPLETE:String = "frameworkCreationComplete";
	public static const APPLICATION_COMPLETE:String = "frameworkApplicationComplete";
	public static const UPDATE_COMPLETE:String = "frameworkUpdatedComplete";
	public static const CHILD_ADDED:String = "frameworkChildAdded";
	public static const CHILD_REMOVED:String = "frameworkChildRemoved";
	public static const ELEMENT_ADDED:String = "frameworkElementAdded";
	public static const ELEMENT_REMOVED:String = "frameworkElementRemoved";
	public static const ADDED_TO_STAGE:String = "addedToStage";
	public static const REMOVED_FROM_STAGE:String = "removedFromStage";
	
	private var _view:Object;
	private var _relatedObject:DisplayObject;
	
	/**
	 * Reference to the visual element that was added or removed.
	 *
	 * This property is relevent for the ELEMENT_ADDED and ELEMENT_REMOVED events.
	 */
	public var element:IVisualElement;
	
	public function ViewEvent( type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false, relatedObject:DisplayObject=null, element:IVisualElement=null ) {
		super( type, bubbles, cancelable );
		
		this.element = element;
		
		_view = view;
		_relatedObject = relatedObject;
	}
	
	public function get relatedObject():DisplayObject {
		return _relatedObject;
	}
	
	public function get view():Object {
		return _view;
	}
	
	override public function clone():Event {
		return new ViewEvent( type, view, bubbles, cancelable, relatedObject, element );
	}
}
}
