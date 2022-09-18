import UIKit

open class FlowLayoutAttributes: UICollectionViewLayoutAttributes {
    
    open override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? FlowLayoutAttributes else { fatalError() }
        return copy
    }
    
}
