import UIKit

public extension FlowLayout {
    
    func insets(for section: Int) -> UIEdgeInsets {
        guard let collectionView = collectionView,let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
                return .zero
        }
        
        return delegate.collectionView?(collectionView, layout: self, insetForSectionAt: section) ?? sectionInset
    }
}
