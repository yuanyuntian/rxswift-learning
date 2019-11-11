//
//  SingleCompletableMaybeViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/11.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

enum DataError:Error {
    case canParseJSON
}

enum CacheError: Error {
    case failedCaching
}



class SingleCompletableMaybeViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "特征序列1：Single、Completable、Maybe"
        view.backgroundColor = UIColor.white
        
        //single
        //single是Observable的另一个版本，但是不像Observable可以发出多个元素，他要么只能发出一个元素，要么产生一个error事件。而且不会共享状态变化。
        //比较常见用于HTTP请求，然后返回一个应答或者一个错误。或者用来描述任何只有一个元素的序列。
        //RxSwift还为Single提供了一个枚举：.success里面包含single的一个元素值，.eeror用于包含错误。
        /*
        enum SingleEvent<Element> {
            case success(Element)
            case error(Swift.Error)
        }
        */
        
        //获取豆瓣某频道下的歌曲信息

        
        //创建single和创建Observable十分相似，下面代码我们定义一个用于生成网络请求single的函数。
 
        getPlaylist("0").subscribe { (event) in
            switch event {
            case .success(let json):
                print("json结果：", json)
            case .error(let error):
                print("发生错误：",error)
            }
        }.disposed(by: disposeBag)
        
        ////也可以使用subscribe(onSuccess:onError:)这种方式
        getPlaylist("0").subscribe(onSuccess: { (json) in
            print("json结果：",json)
        }) { (error) in
            print("发生错误：",error)
        }.disposed(by: disposeBag)
        
        
        //asSingle()可以将Observable转化为single
        Observable.of("1").asSingle().subscribe({print($0)}).disposed(by: disposeBag)
        
        //使用
        cacheLocally().subscribe {completable in
            switch completable {
            case .completed:
                print("保存成功")
            case .error(let error):
                print("失败：",error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getPlaylist(_ channel:String) -> Single<[String:Any]> {
        return Single<[String:Any]>.create { (single) -> Disposable in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, err) in
                if let error = err {
                    single(.error(error))
                    return
                }
                
                guard let data = data,let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),let result = json as? [String:Any] else {
                    single(.error(DataError.canParseJSON))
                    return
                }
                single(.success(result))
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
    
    func cacheLocally() ->Completable {
        return Completable.create { (completable) -> Disposable in
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create()
            }
            completable(.completed)
            return Disposables.create()
        }
    }

}
