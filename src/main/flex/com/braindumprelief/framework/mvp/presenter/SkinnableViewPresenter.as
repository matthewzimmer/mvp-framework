package com.braindumprelief.framework.mvp.presenter {

import com.braindumprelief.framework.mvp.events.SkinnableViewEvent;
import com.braindumprelief.framework.mvp.mvp_framework;

import flash.events.Event;

import mx.core.UIComponent;
import mx.events.FlexEvent;

import spark.components.SkinnableContainer;
import spark.components.supportClasses.SkinnableComponent;

use namespace mvp_framework;

/**
 * The <code>SkinnableViewPresenter</code> does everything its parent class does and
 * exposes two additional methods related to a SkinnableComponent component's
 * <code>partAdded()</code> and <code>partRemoved()</code> methods.
 *
 * <p>In order for a <code>view</code> to be controlled by a <code>SkinnableViewPresenter</code>
 * effectively, it should dispatch the <code>SkinnableViewEvent.SKIN_PART_ADDED</code> and the
 * <code>SkinnableViewEvent.SKIN_PART_REMOVED</code> events from within its <code>partAdded()</code>
 * and <code>partRemoved()</code> method, respectively.</p>
 */
public class SkinnableViewPresenter extends ViewPresenter {
	
	public function SkinnableViewPresenter() {
		super();
	}
	
	override public function set view( value:Object ):void {
		if( value && !( value is SkinnableComponent ) ) {
			throw new Error( 'SkinnableViewPresenter expects an instance of SkinnableComponent as its view.' );
			
		} else {
			super.view = value;
		}
	}
	
	/**
	 * Dispatched when a <code>SkinnableContainer</code> dispatches its <code>FlexEvent.CONTENT_CREATION_COMPLETE</code> event.
	 *
	 * @param event The SkinnableViewEvent dispatched from within a <code>SkinnableViewPresenter</code> instance
	 * whenever <code>SkinnableContainer</code> dispatches its <code>FlexEvent.CONTENT_CREATION_COMPLETE</code>
	 * event.
	 */
	protected function contentCreationComplete( event:SkinnableViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a skin is attached to a <code>SkinnableComponent</code> component.
	 *
	 * <p>Override this function to add behavior to the part.</p>
	 *
	 * @param event The SkinnableViewEvent dispatched from within <code>view#attachSkin()</code>
	 */
	protected function skinAttached( event:SkinnableViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a skin is removed from a SkinnableComponent component.
	 *
	 * <p>Override this function to remove behavior from the part.</p>
	 *
	 * @param event The SkinnableViewEvent dispatched from within <code>view#detachSkin()</code>
	 */
	protected function skinDetatched( event:SkinnableViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a skin part is attached to a <code>SkinnableComponent</code> component.
	 *
	 * For static parts, this will be called after Flex calls <code>view#partAdded()</code>
	 * automatically when it calls the <code>view#attachSkin()</code> method.
	 * For dynamic parts, this will be called after Flex calls <code>view#partAdded()</code>
	 * automatically when it calls the <code>view#createDynamicPartInstance()</code> method.
	 *
	 * <p>Override this function to add behavior to the part.</p>
	 *
	 * @param event The SkinnableViewEvent dispatched from within <code>view#partAdded()</code>
	 */
	protected function partAdded( event:SkinnableViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a skin part is removed from a SkinnableComponent component.
	 *
	 * For static parts, this will be called after Flex calls <code>view#partRemoved()</code>
	 * automatically when it calls the <code>view#detachSkin()</code> method.
	 * For dynamic parts, this will be called after Flex calls <code>view#partRemoved()</code>
	 * automatically when it calls the <code>view#removeDynamicPartInstance()</code> method.
	 *
	 * <p>Override this function to remove behavior from the part.</p>
	 *
	 * @param event The SkinnableViewEvent dispatched from within <code>view#partRemoved()</code>
	 */
	protected function partRemoved( event:SkinnableViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function addEventListeners():void {
		view.addEventListener( SkinnableViewEvent.SKIN_PART_ADDED, partAdded, false, 0, true );
		view.addEventListener( SkinnableViewEvent.SKIN_PART_REMOVED, partRemoved, false, 0, true );
		
		if( view is SkinnableContainer ) {
			addSkinnableContainerListeners();
		}
		
		super.addEventListeners();
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function removeEventListeners():void {
		view.removeEventListener( SkinnableViewEvent.SKIN_PART_ADDED, partAdded );
		view.removeEventListener( SkinnableViewEvent.SKIN_PART_REMOVED, partRemoved );
		
		if( view is SkinnableContainer ) {
			removeSkinnableContainerListeners();
		}
		
		super.removeEventListeners();
	}
	
	/**
	 * Handles all Flex Component Lifecycle events.
	 */
	override mvp_framework function lifecycleEventHandler( event:Event ):void {
		super.lifecycleEventHandler( event );
		
		var viewEvent:SkinnableViewEvent;
		
		switch( event.type ) {
			case FlexEvent.CONTENT_CREATION_COMPLETE:
				view.removeEventListener( event.type, lifecycleEventHandler );
				viewEvent = new SkinnableViewEvent( SkinnableViewEvent.CONTENT_CREATION_COMPLETE, view, event.bubbles, event.cancelable, null, null, null, -1 );
				break;
			
			case "skinChanged":
				var skin:UIComponent = view && view is SkinnableContainer ? SkinnableContainer( view ).skin : null;
				var eventType:String = ( skin != null ) ? SkinnableViewEvent.SKIN_ATTACHED : SkinnableViewEvent.SKIN_DETACHED;
				viewEvent = new SkinnableViewEvent( eventType, view, event.bubbles, event.cancelable, null, null, null, -1, skin );
				break;
			
			default:
				// If the event type handled in this 
				// method is not supported, exit.
				return;
				break;
		}
		
		dispatchEvent( viewEvent );
	}
	
	/**
	 * Adds event listeners specific to a <code>SkinnableContainer</code> component.
	 */
	private function addSkinnableContainerListeners():void {
		view.addEventListener( FlexEvent.CONTENT_CREATION_COMPLETE, lifecycleEventHandler, false, 0, true );
		addEventListener( SkinnableViewEvent.CONTENT_CREATION_COMPLETE, contentCreationComplete, false, 0, true );
		
		view.addEventListener( "skinChanged", lifecycleEventHandler, false, 0, true );
		
		addEventListener( SkinnableViewEvent.SKIN_ATTACHED, skinAttached, false, 0, true );
		addEventListener( SkinnableViewEvent.SKIN_DETACHED, skinDetatched, false, 0, true );
	}
	
	/**
	 * Removes event listeners specific to a <code>SkinnableContainer</code> component.
	 */
	private function removeSkinnableContainerListeners():void {
		view.removeEventListener( FlexEvent.CONTENT_CREATION_COMPLETE, lifecycleEventHandler );
		removeEventListener( SkinnableViewEvent.CONTENT_CREATION_COMPLETE, contentCreationComplete );
		
		view.removeEventListener( "skinChanged", lifecycleEventHandler );
		removeEventListener( SkinnableViewEvent.SKIN_ATTACHED, skinAttached );
		removeEventListener( SkinnableViewEvent.SKIN_DETACHED, skinDetatched );
	}
}
}
