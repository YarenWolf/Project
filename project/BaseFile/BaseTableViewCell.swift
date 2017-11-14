
import UIKit
open class BaseTableViewCell : UITableViewCell {
    open var icon: UIImageView!
    open var line: UIView!
    open var title: UILabel!
    open var script: UILabel!
    ///单例初始化，兼容nib创建
    open class func getInstance() -> Any {
        var instance: BaseTableViewCell? = nil
        let nibFilePath: String = URL(fileURLWithPath: Bundle.main.bundlePath).appendingPathComponent("\(NSStringFromClass(self)).nib").absoluteString
        if FileManager.default.fileExists(atPath: nibFilePath) {
            let o = Bundle.main.loadNibNamed(NSStringFromClass(self), owner: nil, options: nil)?.last
            if (o is BaseTableViewCell) {
                instance = o as? BaseTableViewCell
            }else {
                instance = self.init(style: .default, reuseIdentifier: self.getTableCellIdentifier())
            }
        }else {
            instance = self.init(style: .default, reuseIdentifier: self.getTableCellIdentifier())
        }
        return instance!
    }
    class func getTableCellIdentifier() -> String {
        return "\(NSStringFromClass(self))Identifier"
    }
    required override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadBaseTableCellSubviews()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadBaseTableCellSubviews()
    }
    func loadBaseTableCellSubviews() {
        registerForKVO()
        initUI()
        loadSubViews()
    }
    func loadSubViews() {
        if contentView != nil {
            for obj: Any in subviews {
                if ("UITableViewCellScrollView" == NSStringFromClass(obj as! AnyClass)) {
                    let scrollView = obj as? UIScrollView
                    scrollView?.delaysContentTouches = false
                    //是否先等待一会儿看scrollview 是否有touch 事件发生
                    scrollView?.isExclusiveTouch = true
                    //避免两个对象同时被触发
                    break
                }
            }
            isUserInteractionEnabled = true
            contentView.isUserInteractionEnabled = true
            selectionStyle = .none
        }
    }
    //MARK: KVO
    func registerForKVO() {
        for keyPath: String in observableKeypaths() {
            addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
        }
    }
    func unregisterFromKVO() {
        for keyPath: String in observableKeypaths() {
            removeObserver(self, forKeyPath: keyPath)
        }
    }
    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [String : Any]?, context: UnsafeMutableRawPointer?) {
        if !Thread.isMainThread {
            performSelector(onMainThread: #selector(self.updateUI(forKeypath:)), with: keyPath, waitUntilDone: false)
        }
        else {
            updateUI(forKeypath: keyPath!)
        }
    }
    //MARK: 以下子类重写
    func initUI() {
        backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        icon = UIImageView()
        icon.contentMode = .scaleToFill
        title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        title.numberOfLines = 0
        script = UILabel()
        script.font = UIFont.systemFont(ofSize: 13)
        title.textColor = UIColor(red: 33, green: 34, blue: 35, alpha: 1)
        script.textColor = title.textColor
        line = UIView()
    }
    func setDataWithDict(_ dict: [AnyHashable: Any]) {
        print("请子类重写这个方法")
    }
    func observableKeypaths() -> [String] {
        print("请子类重写这个方法")
        return []
    }
    @objc func updateUI(forKeypath keyPath: String) {
        print("请子类重写这个方法")
    }
    override open func prepareForReuse() {
        super.prepareForReuse()
    }
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    deinit {
        unregisterFromKVO()
        deallocTableCell()
    }
    func deallocTableCell() {
        print("请子类重写这个方法")
    }
}


