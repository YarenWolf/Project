
import UIKit
import SVProgressHUD
import AFNetworking
import MJRefresh
public typealias BaseCollectionLoadedDataBlock = ([Any]?, Bool) -> Swift.Void
open class BaseCollectionView : UICollectionView {
    open var dataArray: NSMutableArray!
    open var urlString: String!
    var curPage: Int = 0
    var task: URLSessionDataTask?
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(frame: CGRect) {
        let lay = UICollectionViewFlowLayout()
        lay.itemSize = CGSize(width: 100, height: 100)
        lay.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        lay.minimumInteritemSpacing = 10
        lay.minimumLineSpacing = 10
        lay.scrollDirection = .vertical
        self.init(frame: frame, collectionViewLayout: lay)
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        alwaysBounceVertical = true
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    //mark: 刷新与加载
    func refresh() {
        mj_footer.endRefreshing()
        loadData(1)
    }
    func loadmore() {
        mj_header.endRefreshing()
        curPage += 1
        loadData(curPage)
    }
    func loadData(_ page: Int) {
        curPage = page
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.show(withStatus: "正在加载...")
        
       
        if !(AFNetworkReachabilityManager.shared().isReachable) {//离线状态
            DispatchQueue.global(qos: .default).async(execute: {() -> Void in// 耗时的操作
                DispatchQueue.main.async(execute: {() -> Void in
//                    block(array, true)
                })
            })
            return
        } else if urlString != nil {
            task = AFHTTPSessionManager().get(urlString, parameters: [], progress: {(_ progress: Progress) -> Void in
            }, success: {(_ task: URLSessionDataTask, _ result: Any?) -> Void in
                print("result:\(result ?? "")")
                self.fillCollectionView(result as! [Any], false)
            }, failure: {(_ task: URLSessionDataTask?, _ error: Error?) -> Void in
                self.fillCollectionView([], true)
            })
        }
    }
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
    //离线、刷新、加载更多数据加载完成处理。
    func fillCollectionView(_ array: [Any], _ isCache: Bool) -> Void {
        print("\(isCache ? "Cache" : "Sever"):\(array)")
        if curPage <= 1 {
            dataArray = array as! NSMutableArray
        }else {
            dataArray.addObjects(from: array)
        }
        self.reloadData()
        mj_footer.endRefreshing()
        SVProgressHUD.dismiss()
    }
}


