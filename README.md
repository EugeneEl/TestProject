# TestProject
Simple test project in swift.
I wrote a small project in order to demonstrate approaches I usually use in real projects.
Architecture: 
- Model-View-Presenter + Coordinators (for navigation);
- ServiceLocator as a DI container for CoreServices;
- Simple didSet for bindings. No RxSwift, ReactiveCocoa "magic".
I don't like RxSwift/ReactiveCocoa because these libs are architectural dependencies. 
They cannot be isolated via some interface and replaced in the project later.
didSet is enough for me to achieve bindings. Also if I want to achieve smth like ordered 'signals' I can simply use async Operation. 
- CoreData models are covered with "plain objects". 

Features:
- login flow;
- some REST API;
- local cache;
