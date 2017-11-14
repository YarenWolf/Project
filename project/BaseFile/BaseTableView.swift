
import UIKit
import SVProgressHUD
import MJRefresh
import AFNetworking
public typealias BaseTableLoadedDataBlock = ([Any]?, Bool) -> Swift.Void
open class BaseTableView : UITableView {
    open var dataArray: NSMutableArray!
    open var urlString: String!
    var curPage: Int = 0
    var task: URLSessionDataTask?
    //MARK: 初始化
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(frame: CGRect) {
        self.init(frame: frame, style: .plain)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    // MARK: 刷新与加载
    func refresh() {
        mj_footer.endRefreshing()
        loadData(1)
    }
    func loadmore() {
        curPage += 1
        mj_header.endRefreshing()
        loadData(curPage)
    }
    func loadData(_ page: Int) {
        curPage = page
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "正在加载...")
        if !(AFNetworkReachabilityManager.shared().isReachable) { //离线状态
            DispatchQueue.global(qos: .default).async(execute: {() -> Void in// 耗时的操作
                DispatchQueue.main.async(execute: {() -> Void in//回到主线程刷新界面
                    // block(self.array, true)
                })
            })
            return
        }else if urlString != nil {
            //网络请求
            task = AFHTTPSessionManager().get(urlString, parameters: [], progress: {(_ progress: Progress) -> Void in
            }, success: {(_ task: URLSessionDataTask, _ result: Any?) -> Void in
                print("result:\(result ?? "")")
                self.fillTableView([result!], false)
            }, failure: {(_ task: URLSessionDataTask?, _ error: Error?) -> Void in
                self.fillTableView([], true)
            })
        }
    }
    func fillTableView(_ array: [Any], _ isCache: Bool) -> Void{
        print("\(isCache ? "Cache" : "Sever"):\(array)")
        if self.curPage <= 1 {
            self.dataArray = array as! NSMutableArray
        }else {
            self.dataArray.addObjects(from:array)
        }
        self.reloadData()
        mj_footer.endRefreshing()
        SVProgressHUD.dismiss()
    }
    //mark 数据源
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identify)
        }
        cell?.textLabel?.text = ((dataArray[indexPath.row] as AnyObject).allValues as NSArray).componentsJoined(by: ",")
        return cell ?? UITableViewCell()
    }
    //MARK: - scrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (delegate?.responds(to: #function))! {
            delegate?.scrollViewDidScroll!(scrollView)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (delegate?.responds(to: #function))! {
            delegate?.scrollViewDidEndDragging!(scrollView, willDecelerate: Bool(decelerate) )
        }
    }
    deinit {
        task?.cancel()
        SVProgressHUD.dismiss()
    }
}


