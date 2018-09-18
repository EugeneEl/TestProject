# TestProject
Simple test project in Swift.
I wrote a small project in order to demonstrate approaches I usually use in real projects.
Architecture: 
- Model-View-Presenter + Coordinators (for navigation). In my opininon it is the best solution for the majority (not all) of mobile projects.  
I don't use VIPER, Redux and other buzzwords architectures;
- <i>ServiceLocator</i> as a DI container for Core Services;
- Workers as higher-level services, they usually use Core Services; 
- Screen states are defined by enum. It helps to define different states of screen in one place.
- Simple <i>didSet</i> for bindings. No RxSwift, ReactiveCocoa "magic".
I don't like RxSwift/ReactiveCocoa because these libs are architectural dependencies. 
They cannot be isolated via some interface and replaced in the project later (without pain).
<i>didSet</i> is enough for me to achieve bindings. Also if I want to achieve smth like ordered 'signals' I can simply use async <i>Operation</i>. 
- CoreData models are covered by "plain objects". It helps to isolate higher level code from the data layer implementation; 
- CocoaPods as a dependency manager. 

Features:
- login flow;
- some REST API;
- local cache.
