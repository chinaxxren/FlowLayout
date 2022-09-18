import UIKit

internal extension FlowLayout {

    // Returns attributes for a section background
    func backgroundAttributes(section: Int, numberOfItems: Int, insets: UIEdgeInsets) -> FlowLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }

        let firstIndex = 0
        let lastIndex = numberOfItems - 1
        guard lastIndex >= 0 else { return nil }

        guard let firstAttributes = super.layoutAttributesForItem(at: IndexPath(item: firstIndex, section: section)),
            let lastAttributes = super.layoutAttributesForItem(at: IndexPath(item: lastIndex, section: section)) else {
                return nil
        }

        let indexPath = IndexPath(item: 0, section: section)
        let bgAttributes = FlowLayoutAttributes(forSupplementaryViewOfKind: BackgroundReusableView.elementKindBackground, with: indexPath)

        var x: CGFloat = 0
        var w: CGFloat = collectionView.bounds.width
        var y: CGFloat = firstAttributes.frame.minY
        var h: CGFloat = lastAttributes.frame.maxY - firstAttributes.frame.minY

        var frame: CGRect = .zero
        let headerHeight = super.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)?.size.height ?? 0
        let footerHeight = super.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath)?.size.height ?? 0
        
        x = insets.left
        y = y - headerHeight
        w = w - insets.left  - insets.right
        h += headerHeight + footerHeight
        
        frame = CGRect(x: x, y: y, width: w, height: h)
        print("\(section) \(h)")
        bgAttributes.frame = frame
        bgAttributes.zIndex = -1

        return bgAttributes
    }

}
