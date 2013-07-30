package com.braindumprelief.framework.mvp.events {

import flash.events.Event;

import mx.core.IVisualElement;
import mx.core.UIComponent;

/**
 * A SkinnableViewEvent contains the name and instance of the part that
 * was added to or removed from a SkinnableComponent.  It also holds reference to
 * the index and IVisualElement for situations where a <code>SkinnableContainer</code>
 * dispatches its <code>ElementExistenceEvent.ELEMENT_ADD</code> or
 * <code>ElementExistenceEvent.ELEMENT_REMOVE</code> event.
 */
public class SkinnableViewEvent extends ViewEvent {
	
	public static const CONTENT_CREATION_COMPLETE:String = "frameworkContentCreationComplete";
	public static const SKIN_ATTACHED:String = "frameworkSkinAttached";
	public static const SKIN_DETACHED:String = "frameworkSkinDetached";
	public static const SKIN_PART_ADDED:String = "frameworkSkinPartAdded";
	public static const SKIN_PART_REMOVED:String = "frameworkSkinPartRemoved";
	
	/**
	 * The index where the element was added or removed.
	 *
	 * This property is relevent for the ELEMENT_ADDED and ELEMENT_REMOVED events.
	 */
	public var index:int;
	
	/**
	 * The name of the part.
	 *
	 * This property is relevent for the SKIN_PART_ADDED and SKIN_PART_REMOVED events.
	 */
	public var partName:String;
	
	/**
	 * The instance of the part.
	 *
	 * This property is relevent for the SKIN_PART_ADDED and SKIN_PART_REMOVED events.
	 */
	public var instance:Object;
	
	/**
	 * The skin class that was attached or detatched from a SkinnableComponent.
	 *
	 * This property is relevent for the SKIN_ATTACHED and SKIN_DETACHED events.
	 */
	public var skin:UIComponent;
	
	public function SkinnableViewEvent( type:String, 
										view:Object, 
										bubbles:Boolean=false, 
										cancelable:Boolean=false, 
										partName:String=null, 
										instance:Object=null, 
										element:IVisualElement=null, 
										index:int=-1, 
										skin:UIComponent=null ) {
		super( type, view, bubbles, cancelable, null, element );
		
		this.partName = partName;
		this.instance = instance;
		this.index = index;
		this.skin = skin;
	}
	
	override public function clone():Event {
		return new SkinnableViewEvent( type, view, bubbles, cancelable, partName, instance, element, index, skin );
	}
}
}
