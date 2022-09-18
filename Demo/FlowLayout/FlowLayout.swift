import UIKit
import os.log

open class FlowLayout: UICollectionViewFlowLayout {

    internal var cachedBackgroundAttributes: [Int: FlowLayoutAttributes] = [:]
        
    // MARK: - Invalidation
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    open override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        guard let context = super.invalidationContext(forBoundsChange: newBounds) as? FlowLayoutInvalidationContext else {
            fatalError("Expected: \(FlowLayoutInvalidationContext.self)")
        }
        
        guard let collectionView = collectionView else { return context }
        
        // if the width has changed, invalidate the metrics
        if collectionView.bounds.width != newBounds.width {
            context.invalidateFlowLayoutDelegateMetrics = true
            context.invalidateBackgrounds = true
        }
        
        return context
    }
    
    open override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        guard let collectionView = collectionView else { return }

        super.invalidateLayout(with: context)

        if context.invalidateEverything {
            cachedBackgroundAttributes.removeAll()
        }

        guard let context = context as? FlowLayoutInvalidationContext else { return }

        if context.invalidateBackgrounds
            || context.invalidateFlowLayoutDelegateMetrics
            || context.invalidateDataSourceCounts {
            cachedBackgroundAttributes.removeAll()
        }
        
        // if a section has been invalidated in any way, we need to invalidate all backgrounds after (and including) that section
        if let section = Array(context.invalidatedSections).sorted().first {
            for index in 0..<(collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0) {
                cachedBackgroundAttributes[index] = nil
            }
        }
    }
    
    // MARK: - Prepare

    open override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let sectionCount = collectionView.dataSource?.numberOfSections?(in: collectionView) ?? 0
        
        for section in 0..<sectionCount {
            guard cachedBackgroundAttributes[section] == nil else { continue }
                        
            let itemCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
            let insets = self.insets(for: section)
            
            cachedBackgroundAttributes[section] = backgroundAttributes(section: section, numberOfItems: itemCount, insets: insets)
        }
    }
    
    // MARK: - Attributes
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var originalAttributes = super.layoutAttributesForElements(in: rect) ?? []
                
        for attr in originalAttributes  {
            let section = attr.indexPath.section
            let sectionInset = self.insets(for: section)
            
            if attr.representedElementKind == UICollectionView.elementKindSectionHeader ||
                attr.representedElementKind == UICollectionView.elementKindSectionFooter {
                var frame = attr.frame
                frame.origin.x = sectionInset.left
                frame.origin.y = frame.origin.y + sectionInset.top
                frame.size.width =  frame.size.width - sectionInset.left - sectionInset.right
                attr.frame = frame
            } 
        }
        
        let attributes = cachedBackgroundAttributes.values.filter({ $0.frame.intersects(rect) })
        originalAttributes.append(contentsOf: attributes)
        return originalAttributes
    }
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        guard let attr = attr else {
            return nil
        }

        if elementKind == UICollectionView.elementKindSectionHeader ||  elementKind == UICollectionView.elementKindSectionFooter   {
            var frame = attr.frame
            frame.origin.x = sectionInset.left
            frame.size.width =  frame.size.width - sectionInset.left - sectionInset.right
            attr.frame = frame
        }
        
        return attr
       }
    
    // MARK: - Override class types
    
    open override class var layoutAttributesClass: AnyClass {
        return FlowLayoutAttributes.self
    }
    
    open override class var invalidationContextClass: AnyClass {
        return FlowLayoutInvalidationContext.self
    }
    
}
