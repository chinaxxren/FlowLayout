
import UIKit

class CollectionReusableHeaderView: UICollectionReusableView {
    
    lazy var label: UILabel = {
       let instance = UILabel()
        instance.textAlignment = .center
        instance.textColor = .black
        instance.font = .systemFont(ofSize: 14)
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
