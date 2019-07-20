# TestProject
Simple test project in Swift.
I wrote a small project in order to demonstrate approaches I usually use in real projects.
Architecture: 
- Model-View-Presenter + Coordinators (for navigation); 
- I don't use storyboards because with storyboard implementation we cannot write custom initializer for VC and inject dependencies in init. Otherwise we will have optional presenters/routers;
- I prefer to setup UI in code using SnapKit DSL to implement layout. In this way it would be much easier to implement adaptive designs for smaller devices (like iPhone5) instead of making constraints outlets. As a bonus of this approach we reduce number of xib files in project;
- For forms I use scrollView + stackView approach. I avoid using UITableView for forms. UITableView should be used when we have infinite list and cell reuse required. Even complicated form can be described by some enum and we can implement it within stackView;
- <i>ServiceLocator</i> as a DI container for Core Services;
- Workers as higher-level services, they usually use Core Services; 
- Screen states are defined by enum. It helps to define different states of screen in one place.
- Simple <i>didSet</i> for bindings. 
<i>didSet</i> is enough for me to achieve bindings. Also if I want to achieve smth like ordered 'signals' I would simply suggest to use async <i>Operation</i>. 
- CocoaPods as a dependency manager. 

Features:
- login flow;
- some REST API;
