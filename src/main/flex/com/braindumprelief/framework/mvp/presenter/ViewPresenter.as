package com.braindumprelief.framework.mvp.presenter {

import com.braindumprelief.framework.mvp.events.ViewEvent;
import com.braindumprelief.framework.mvp.mvp_framework;

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import mx.core.IVisualElement;
import mx.core.UIComponent;
import mx.events.ChildExistenceChangedEvent;
import mx.events.FlexEvent;

import spark.events.ElementExistenceEvent;

use namespace mvp_framework;

/**
 * A ViewPresenter takes care of hooking up the core listeners for a mediated
 * view.  It then exposes methods to be overridden by a base class to act
 * upon a given view-related event.
 */
public class ViewPresenter implements Presenter {
	
	/**
	 * A global reference to the stage. It is set to a valid instance the first time 
	 * a presenter's view is added to the stage. This variable may also be set externally 
	 * through the <code>setStage</code> method.
	 */
	protected static var stage:Stage = null;
	
	/**
	 * A private, centralized event bus (i.e., communication channel) that
	 * all presenters can dispatch and/or listen to events on.
	 */
	protected static var presenterEventBus:IEventDispatcher;
	private static var instance:Presenter;
	
	private var dispatcher:IEventDispatcher;
	private var _view:Object;
	
	{
		if( !instance ) {
			instance = new ViewPresenter();
			presenterEventBus = new EventDispatcher( instance );
		}
	}
	
	public function ViewPresenter() {
		dispatcher = new EventDispatcher( this );
	}
	
	/**
	 * @inheritDoc
	 */
	[Bindable( "viewChange" )]
	public function get view():Object {
		return _view;
	}
	
	/**
	 * @inheritDoc
	 */
	public function set view( value:Object ):void {
		if( _view != value ) {
			if( _view ) {
				removeEventListeners();
			}
			
			_view = value;
			
			if( _view ) {
				addEventListeners();
				invalidateProperties();
			}
			
			dispatchEvent( new Event( "viewChange" ) );
		}
	}
	
	public function invalidateProperties():void {
		if( view is UIComponent ) {
			UIComponent( view ).invalidateProperties();
		}
	}
	
	/**
	 *
	 */
	protected function applyPresenterModelData():void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 *
	 */
	protected function applyViewModelData():void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when the Flex framework dispatches the view component's
	 * FlexEvent.PREINITIALIZE event. A base class should override
	 * this method to handle the event.
	 */
	protected function preinitialize( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when the Flex framework dispatches the view component's
	 * FlexEvent.INITIALIZE event. A base class should override
	 * this method to handle the event.
	 */
	protected function initialize( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when the Flex framework dispatches the view component's
	 * FlexEvent.CREATION_COMPLETE event. A base class should override
	 * this method to handle the event.
	 */
	protected function creationComplete( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when the Flex framework dispatches the view component's
	 * FlexEvent.APPLICATION_COMPLETE event. A base class should override
	 * this method to handle the event.
	 */
	protected function applicationComplete( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when the Flex framework dispatches the view component's
	 * FlexEvent.UPDATE_COMPLETE event. A base class should override
	 * this method to handle the event.
	 */
	protected function updateComplete( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a child DisplayObject is added to the display list.
	 * A base class should override this method to handle the event.
	 */
	protected function childAdded( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when a child DisplayObject is removed from the display list.
	 * A base class should override this method to handle the event.
	 */
	protected function childRemoved( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when an element is added to a <code>Container</code> component.
	 *
	 * @param event The ViewEvent dispatched from within a <code>ViewPresenter</code> instance
	 * whenever an element is added to a <code>Container</code>
	 */
	protected function elementAdded( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Dispatched when an element is added to a <code>Container</code> component.
	 *
	 * @param event The ViewEvent dispatched from within a <code>ViewPresenter</code> instance
	 * whenever an element is removed from a <code>Container</code>
	 */
	protected function elementRemoved( event:ViewEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Triggered whenever the view dispatches a FlexEvent.DATA_CHANGE event.
	 *
	 * @param event The FlexEvent dispatched from within a view component
	 * whenever the view dispatches a FlexEvent.DATA_CHANGE event.
	 */
	protected function dataChange( event:FlexEvent ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Triggered when the view element has been added to the Display List (i.e., Stage).
	 */
	protected function addedToStage( event:Event ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Triggered when the view element has been removed from the Display List (i.e., Stage).
	 */
	protected function removedFromStage( event:Event ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Triggered whenever an arbitrary view element has been added to the Display List (i.e., Stage).
	 */
	protected function elementAddedToStage( event:Event ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Triggered whenever an arbitrary view element has been removed from the Display List (i.e., Stage).
	 */
	protected function elementRemovedFromStage( event:Event ):void {
		// Base classes are responsible for overriding this method
	}
	
	/**
	 * Sets the static reference to the stage.
	 */
	mvp_framework function setStageReference( value:Stage ):void {
		if( !stage ) {
			stage = value;
		}
	}
	
	private function addStageListeners():void {
		stage.addEventListener( Event.ADDED, elementAddedToStage );
		stage.addEventListener( Event.REMOVED, elementRemovedFromStage );
	}
	
	/**
	 * Handles all Flex Component Lifecycle events.
	 */
	mvp_framework function lifecycleEventHandler( event:Event ):void {
		var eventToDispatch:String;
		var viewEvent:ViewEvent;
		var element:IVisualElement = null;
		var relatedObject:DisplayObject = null;
		
		switch( event.type ) {
			case FlexEvent.PREINITIALIZE:
				eventToDispatch = ViewEvent.PREINITIALIZE;
				_view.removeEventListener( event.type, lifecycleEventHandler );
				break;
			
			case FlexEvent.INITIALIZE:
				eventToDispatch = ViewEvent.INITIALIZE;
				_view.removeEventListener( event.type, lifecycleEventHandler );
				break;
			
			case FlexEvent.CREATION_COMPLETE:
				eventToDispatch = ViewEvent.CREATION_COMPLETE;
				_view.removeEventListener( event.type, lifecycleEventHandler );
				break;
			
			case FlexEvent.APPLICATION_COMPLETE:
				eventToDispatch = ViewEvent.APPLICATION_COMPLETE;
				_view.removeEventListener( event.type, lifecycleEventHandler );
				break;
			
			case FlexEvent.UPDATE_COMPLETE:
				eventToDispatch = ViewEvent.UPDATE_COMPLETE;
				break;
			
			case ElementExistenceEvent.ELEMENT_ADD:
				eventToDispatch = ViewEvent.ELEMENT_ADDED;
				element = ElementExistenceEvent( event ).element;
				break;
			
			case ElementExistenceEvent.ELEMENT_REMOVE:
				eventToDispatch = ViewEvent.ELEMENT_REMOVED;
				element = ElementExistenceEvent( event ).element;
				break;
			
			case ElementExistenceEvent.ELEMENT_ADD:
				eventToDispatch = ViewEvent.ELEMENT_ADDED;
				element = ElementExistenceEvent( event ).element;
				break;
			
			case ElementExistenceEvent.ELEMENT_REMOVE:
				eventToDispatch = ViewEvent.ELEMENT_REMOVED;
				element = ElementExistenceEvent( event ).element;
				break;
			
			case ChildExistenceChangedEvent.CHILD_ADD:
				eventToDispatch = ViewEvent.CHILD_ADDED;
				relatedObject = ChildExistenceChangedEvent( event ).relatedObject;
				break;
			
			case ChildExistenceChangedEvent.CHILD_REMOVE:
				eventToDispatch = ViewEvent.CHILD_REMOVED;
				relatedObject = ChildExistenceChangedEvent( event ).relatedObject;
				break;
			
			case Event.ADDED_TO_STAGE:
				eventToDispatch = ViewEvent.ADDED_TO_STAGE;
				break;
			
			case Event.REMOVED_FROM_STAGE:
				eventToDispatch = ViewEvent.REMOVED_FROM_STAGE;
				break;
			
			default:
				// If the event type handled in this 
				// method is not supported, exit.
				return;
				break;
		}
		
		if( !viewEvent ) {
			viewEvent = new ViewEvent( eventToDispatch, _view, event.bubbles, event.cancelable, relatedObject, element );
		}
		
		dispatchEvent( viewEvent );
	}
	
	/**
	 * Adds all event listeners for a given view.  Triggered whenever a <code>ViewPresenter#view</code>
	 * is set.  Failure to call the super method will result of a non-functional presenter.
	 */
	protected function addEventListeners():void {
		// Flex Component Lifecycle Events
		_view.addEventListener( FlexEvent.PREINITIALIZE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( FlexEvent.INITIALIZE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( FlexEvent.CREATION_COMPLETE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( FlexEvent.APPLICATION_COMPLETE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( FlexEvent.UPDATE_COMPLETE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( Event.ADDED_TO_STAGE, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( Event.REMOVED_FROM_STAGE, lifecycleEventHandler, false, 0, true );
		
		_view.addEventListener( FlexEvent.DATA_CHANGE, dataChange, false, 0, true );
		
		if( stage == null ) {
			_view.addEventListener( Event.ADDED_TO_STAGE, internalAddedToStage );
		} else {
			addStageListeners();
		}
		
		// DisplayObjectContainer Events
		_view.addEventListener( ChildExistenceChangedEvent.CHILD_ADD, internalChildAddHandler, false, 0, true );
		_view.addEventListener( ChildExistenceChangedEvent.CHILD_REMOVE, internalChildRemoveHandler, false, 0, true );
		
		_view.addEventListener( ElementExistenceEvent.ELEMENT_ADD, lifecycleEventHandler, false, 0, true );
		_view.addEventListener( ElementExistenceEvent.ELEMENT_REMOVE, lifecycleEventHandler, false, 0, true );
		
		
		// Framework events corresponding to Flex Component Lifecycle Events
		addEventListener( ViewEvent.PREINITIALIZE, preinitialize, false, 0, true );
		addEventListener( ViewEvent.INITIALIZE, initialize, false, 0, true );
		addEventListener( ViewEvent.CREATION_COMPLETE, creationComplete, false, 0, true );
		addEventListener( ViewEvent.APPLICATION_COMPLETE, applicationComplete, false, 0, true );
		addEventListener( ViewEvent.UPDATE_COMPLETE, updateComplete, false, 0, true );
		
		
		// Framework events corresponding to DisplayObjectContainer Events
		addEventListener( ViewEvent.CHILD_ADDED, childAdded, false, 0, true );
		addEventListener( ViewEvent.CHILD_REMOVED, childRemoved, false, 0, true );
		
		
		// Framework events corresponding to IVisualElement Events
		addEventListener( ViewEvent.ELEMENT_ADDED, elementAdded, false, 0, true );
		addEventListener( ViewEvent.ELEMENT_REMOVED, elementRemoved, false, 0, true );
		
		
		// Framework events corresponding to DisplayObject Events
		addEventListener( ViewEvent.ADDED_TO_STAGE, addedToStage, false, 0, true );
		addEventListener( ViewEvent.REMOVED_FROM_STAGE, removedFromStage, false, 0, true );
	}
	
	/**
	 * Removes all event listeners for a given view.
	 */
	protected function removeEventListeners():void {
		// Flex Component Lifecycle Events
		_view.removeEventListener( FlexEvent.PREINITIALIZE, lifecycleEventHandler );
		_view.removeEventListener( FlexEvent.INITIALIZE, lifecycleEventHandler );
		_view.removeEventListener( FlexEvent.CREATION_COMPLETE, lifecycleEventHandler );
		_view.removeEventListener( FlexEvent.APPLICATION_COMPLETE, lifecycleEventHandler );
		_view.removeEventListener( FlexEvent.UPDATE_COMPLETE, lifecycleEventHandler );
		_view.removeEventListener( Event.ADDED_TO_STAGE, lifecycleEventHandler );
		_view.removeEventListener( Event.REMOVED_FROM_STAGE, lifecycleEventHandler );
		
		_view.removeEventListener( FlexEvent.DATA_CHANGE, dataChange );
		_view.removeEventListener( Event.ADDED_TO_STAGE, internalAddedToStage );
		
		
		// DisplayObjectContainer Events
		_view.removeEventListener( ChildExistenceChangedEvent.CHILD_ADD, internalChildAddHandler );
		_view.removeEventListener( ChildExistenceChangedEvent.CHILD_REMOVE, internalChildRemoveHandler );
		
		_view.removeEventListener( ElementExistenceEvent.ELEMENT_ADD, lifecycleEventHandler );
		_view.removeEventListener( ElementExistenceEvent.ELEMENT_REMOVE, lifecycleEventHandler );
		
		
		// Framework events corresponding to Flex Component Lifecycle Events
		removeEventListener( ViewEvent.PREINITIALIZE, preinitialize );
		removeEventListener( ViewEvent.INITIALIZE, initialize );
		removeEventListener( ViewEvent.CREATION_COMPLETE, creationComplete );
		removeEventListener( ViewEvent.APPLICATION_COMPLETE, applicationComplete );
		removeEventListener( ViewEvent.UPDATE_COMPLETE, updateComplete );
		
		
		// Framework events corresponding to DisplayObjectContainer Events
		removeEventListener( ViewEvent.CHILD_ADDED, childAdded );
		removeEventListener( ViewEvent.CHILD_REMOVED, childRemoved );
		
		
		// Framework events corresponding to IVisualElement Events
		removeEventListener( ViewEvent.ELEMENT_ADDED, elementAdded );
		removeEventListener( ViewEvent.ELEMENT_REMOVED, elementRemoved );
		
		
		// Framework events corresponding to DisplayObject Events
		removeEventListener( ViewEvent.ADDED_TO_STAGE, addedToStage );
		removeEventListener( ViewEvent.REMOVED_FROM_STAGE, removedFromStage );
	}
	
	private function internalAddedToStage( event:Event ):void {
		var element:DisplayObject;
		
		if( event.currentTarget is DisplayObject ) {
			element = DisplayObject( event.currentTarget );
			element.removeEventListener( Event.ADDED_TO_STAGE, internalAddedToStage );
			setStageReference( element.stage );
			addStageListeners();
		}
	}
	
	/**
	 * Internally handles the ChildExistenceChangedEvent.CHILD_ADD event
	 * dispatched by the Flex Framework and dispatches our custom
	 * framework ViewEvent.CHILD_ADDED event.
	 */
	private function internalChildAddHandler( event:ChildExistenceChangedEvent ):void {
		dispatchEvent( new ViewEvent( ViewEvent.CHILD_ADDED, _view, event.bubbles, event.cancelable, event.relatedObject ) );
	}
	
	/**
	 * Internally handles the ChildExistenceChangedEvent.CHILD_REMOVE event
	 * dispatched by the Flex Framework and immediately dispatches our custom
	 * framework ViewEvent.CHILD_ADDED event.
	 */
	private function internalChildRemoveHandler( event:ChildExistenceChangedEvent ):void {
		dispatchEvent( new ViewEvent( ViewEvent.CHILD_REMOVED, _view, event.bubbles, event.cancelable, event.relatedObject ) );
	}
	
	/**
	 * @inheritDoc
	 */
	public function addEventListener( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ):void {
		dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
	}
	
	/**
	 * @inheritDoc
	 */
	public function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ):void {
		dispatcher.removeEventListener( type, listener, useCapture );
	}
	
	/**
	 * @inheritDoc
	 */
	public function dispatchEvent( event:Event ):Boolean {
		return dispatcher.dispatchEvent( event );
	}
	
	/**
	 * @inheritDoc
	 */
	public function hasEventListener( type:String ):Boolean {
		return dispatcher.hasEventListener( type );
	}
	
	/**
	 * @inheritDoc
	 */
	public function willTrigger( type:String ):Boolean {
		return dispatcher.willTrigger( type );
	}
}
}
