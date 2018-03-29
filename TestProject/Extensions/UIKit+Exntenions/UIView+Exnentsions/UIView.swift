//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.
//

import UIKit
import SnapKit

protocol ViewInitializing {
    
}

struct ShadowUI {
    let color: CGColor
    let radius: CGFloat
    let offset: CGSize
    let opacity: Float
}

extension UIView: ViewInitializing {}

extension ViewInitializing where Self: UIView {
    static func instantiateView() -> Self {
        
        let loadedElements = Bundle.main.loadNibNamed(Self.viewName(), owner: nil, options: nil)!
        let loadedView = loadedElements.filter({$0 is Self}).first
        
        assert(loadedView != nil, "wrong nib name for view: \(Self.viewName)")
        
        return loadedView as! Self
    }
}

extension UIView {

    static func viewName() -> String {
        return String(describing: self)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    // Layout extensions
    
    func constraintToSuperviewEdges() {
        self.snp.makeConstraints { make in
            make.left.equalTo(self.superview!.snp.left)
            make.right.equalTo(self.superview!.snp.right)
            make.top.equalTo(self.superview!.snp.top)
            make.bottom.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func constraintToSuperviewEdges(leading: CGFloat, trainling: CGFloat, bottom: CGFloat, top: CGFloat) {
        self.snp.makeConstraints { make in
            make.left.equalTo(self.superview!.snp.left).inset(leading)
            make.right.equalTo(self.superview!.snp.right).inset(trainling)
            make.top.equalTo(self.superview!.snp.top).inset(top)
            make.bottom.equalTo(self.superview!.snp.bottom).inset(bottom)
        }
    }
    
    func constraintToSuperViewCenter() {
        self.snp.makeConstraints { make in
            make.centerX.equalTo(self.superview!)
            make.centerY.equalTo(self.superview!)
            make.width.equalTo(self.frame.size.width)
            make.height.equalTo(self.frame.size.height)
        }
    }
    
    func constraintToSuperViewCenterRelyOnIntristicSize() {
        self.snp.makeConstraints { make in
            make.centerX.equalTo(self.superview!)
            make.centerY.equalTo(self.superview!)
            make.width.equalTo(self.intrinsicContentSize.width)
            make.height.equalTo(self.intrinsicContentSize.height)
        }
    }
}
