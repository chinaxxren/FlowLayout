import UIKit

/// A UICollectionViewFlowLayoutInvalidationContext subclass that adds support for global headers and footers.
///
/// This class should be used with `Composed.FlowLayout`
public final class FlowLayoutInvalidationContext: UICollectionViewFlowLayoutInvalidationContext {
    
    /// Invalidates the background for the specified section
    /// - Parameter section: The section to invalidate
    public func invalidateBackground(for section: Int) {
        invalidateSupplementaryElements(ofKind: BackgroundReusableView.elementKindBackground, at: [IndexPath(item: 0, section: section)])
        invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader, at: [IndexPath(item: 0, section: section)])
        invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionFooter, at: [IndexPath(item: 0, section: section)])
    }
    
    
    private var _invalidateBackgrounds: Bool = false
    public var invalidateBackgrounds: Bool {
        get { return _invalidateBackgrounds }
        set {
            guard newValue else { return }
            _invalidateBackgrounds = newValue
        }
    }
    
    internal var invalidatedSections: Set<Int> {
        let headers = invalidatedSupplementaryIndexPaths?[UICollectionView.elementKindSectionHeader]
            .map { $0 }?
            .map { $0.section } ?? []
        
        let footers = invalidatedSupplementaryIndexPaths?[UICollectionView.elementKindSectionFooter]
            .map { $0 }?
            .map { $0.section } ?? []
        
        let backgrounds = invalidatedSupplementaryIndexPaths?[BackgroundReusableView.elementKindBackground]
            .map { $0 }?
            .map { $0.section } ?? []
        
        let items = invalidatedItemIndexPaths?.map { $0.section } ?? []
        return Set(headers + footers + items + backgrounds)
    }
    
}

extension FlowLayoutInvalidationContext {
    
    public override var debugDescription: String {
        return """
        ---
        Everything: \(invalidateEverything)
        DataSource: \(invalidateDataSourceCounts)
        All Backgrounds: \(invalidateBackgrounds)
        All Attributes: \(invalidateFlowLayoutAttributes)
        All Metrics: \(invalidateFlowLayoutDelegateMetrics)
        Items: \(invalidatedItemIndexPaths ?? [])
        Supplementary: \(invalidatedSupplementaryIndexPaths ?? [:])
        ---
        """
    }
    
}
