
import UIKit
import AFNetworking
//public typealias backBlock = (Any?) -> Swift.Void
class BaseViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    @objc open var userInfo: Any!
    open var otherInfo: Any!
    open var tableView: BaseTableView!
    open var collectionView: BaseCollectionView!
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white ,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name:.AFNetworkingReachabilityDidChange, object: AFNetworkReachabilityStatus.self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //pragma mark - Methods
    func push(_ controller: BaseViewController, withInfo info: Any) -> BaseViewController {
        return push(controller, withInfo: info, withTitle: "", withOther: nil, tabBarHid: true)
    }
    func push(_ controller: BaseViewController, withInfo info: Any, withTitle title: String) -> BaseViewController {
        return push(controller, withInfo: info, withTitle: title, withOther: nil, tabBarHid: true)
    }
    func push(_ controller: BaseViewController, withInfo info: Any, withTitle title: String, withOther other: Any?) -> BaseViewController {
        return push(controller, withInfo: info, withTitle: title, withOther: other, tabBarHid: true)
    }
    func push(_ controller: BaseViewController, withInfo info: Any, withTitle title: String, withOther other: Any?, tabBarHid abool: Bool) -> BaseViewController {
        print("跳转到 \(title) 页面Base UserInfo:\(info)Base OtherInfo:\(String(describing: other))")
        if controller.responds(to: #selector(setter: userInfo)) {
            controller.userInfo = info as? [String : Any] ?? [String : Any]()
            controller.otherInfo = other
        }
        controller.title = title
        controller.hidesBottomBarWhenPushed = abool
        navigationController?.pushViewController(controller, animated: true)
        return controller
    }
    func pop(toTheControllerNamed controller: String) {
        pop(toControllerNamed: controller, withSel: nil, withObj: nil)
    }
    func pop(toControllerNamed controllerstr: String, withSel sel: Selector?, withObj info: Any?) {
        print("返回到 \(controllerstr) 页面")
        for controller: UIViewController in (navigationController?.viewControllers)! {
            if (String.init(describing: controller) == controllerstr) {
                if controller.responds(to: sel) {
                    controller.perform(sel!, with: info, afterDelay: 0.01)
                }
                navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
    func goback() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    //MARK: UItableViewDelegagte
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableView.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BaseTableViewCell
        if cell == nil {
            cell = BaseTableViewCell.getInstance() as? BaseTableViewCell
        }
        cell?.setDataWithDict(self.tableView.dataArray[indexPath.row] as! [AnyHashable:AnyObject])
        return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    //MARK: 子类重写
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("请子类重写这个方法")
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("请子类重写这个方法")
        return ""
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print("请子类重写这个方法")
        return ""
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 1 添加一个删除按钮
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "删除", handler: {(_ action: UITableViewRowAction, _ indexPath: IndexPath) -> Void in
            self.tableView.dataArray.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        // 2 添加一个置顶按钮
        let topRowAction = UITableViewRowAction(style: .normal, title: "置顶", handler: {(_ action: UITableViewRowAction, _ indexPath: IndexPath) -> Void in
            self.tableView.dataArray.exchangeObject(at: indexPath.row, withObjectAt: 0)
            let firstIndexPath = IndexPath(row: 0, section: indexPath.section)
            tableView.moveRow(at: indexPath, to: firstIndexPath)
        })
        topRowAction.backgroundColor = .lightGray
        return [deleteRowAction, topRowAction]
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let row: Int = indexPath.row
        if editingStyle == .delete {
            self.tableView.dataArray.removeObject(at: row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        else {
            self.tableView.dataArray.add(self.tableView.dataArray[indexPath.row])
            tableView.insertRows(at: [indexPath], with: .left)
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("请子类重写这个方法")
        self.tableView.dataArray.removeObject(at: sourceIndexPath.row)
        self.tableView.dataArray.insert(self.tableView.dataArray[sourceIndexPath.row], at: destinationIndexPath.row)
    }
    //MARK: UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.collectionView?.dataArray.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView .dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.getColloctionCellIdentifier(), for: indexPath) as? BaseCollectionViewCell
        if cell == nil {
            cell = BaseCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        }
        cell?.setCollectionDataWithDic(self.collectionView.dataArray[indexPath.row] as! [AnyHashable:AnyObject])
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    //子类重写
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("请子类重写这个方法")
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("请子类重写这个方法")
    }
    @objc func reachabilityChanged(_ notification: Notification) {
        if notification.object as? AFNetworkReachabilityStatus == AFNetworkReachabilityStatus.reachableViaWiFi {
            print("网络状态改变了.")
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



