
import Foundation
import Material

class TextInput: TextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dividerNormalColor = Colors.COLOR_WHITE
        self.dividerActiveColor = Colors.COLOR_WHITE
        self.textColor = Colors.COLOR_WHITE
        self.placeholderNormalColor = Colors.COLOR_WHITE
        self.placeholderActiveColor = Colors.COLOR_WHITE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
