Flex MVP Framework
==================

A Model-View-Presenter framework used to abstract away the various component lifecycle phases that exist in every Flex application while providing a clean API for handling view behavior and updating the view based on changes to the model. The framework also makes it trivial to react to the various component lifecycle phases without needing to know their corresponding event names.

The majority of the magic happens in [SkinnableViewPresenter.as](https://github.com/matthewzimmer/mvp-framework/blob/master/src/main/flex/com/braindumprelief/framework/mvp/presenter/SkinnableViewPresenter.as) and [ViewPresenter.as](https://github.com/matthewzimmer/mvp-framework/blob/master/src/main/flex/com/braindumprelief/framework/mvp/presenter/ViewPresenter.as).

Also, out of the box, every subclass of ViewPresenter is subscribed to a private event bus for encapsulated communication among other ViewPresenters. For example, a user presses on an "Edit Person" button in a list of Person models which is handled by MasterPersonPresenter. MasterPersonPresenter may then dispatch a "editPerson" event on the private event bus along with the corresponding Person model which DetailPersonPresenter will be listening for to populate the PersonDetailView. Or imagine a complex composite class made up of many compoents which need to update their state based on changes in one or more composite views based on user actions. Communicating the user actions in the private event bus makes such a complex scenario relatively trivial.
