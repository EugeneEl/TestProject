//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.
//
import Foundation
import UIKit

extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CellInitializing {}

extension CellInitializing where Self: UICollectionViewCell {
    static func dequeueFromCollectionView(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        let identifier = self.cellIdentifier()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Self
        return cell
    }
}
