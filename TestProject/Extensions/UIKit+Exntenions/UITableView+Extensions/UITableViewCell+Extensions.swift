//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func fixSeparator() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

protocol CellInitializing {
    
}

extension UITableViewCell: CellInitializing {}

extension CellInitializing where Self: UITableViewCell {
    static func dequeueFromTableView(_ tableView: UITableView) -> Self {
        let identifier = self.cellIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! Self
        return cell
    }
}
