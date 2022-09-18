
import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    lazy var label: UILabel = {
       let instance = UILabel()
        instance.textAlignment = .center
        instance.textColor = .black
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20, y: 0, width: bounds.width - 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
