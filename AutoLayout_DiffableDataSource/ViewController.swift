//
//  ViewController.swift
//  AutoLayout_DynamicTableView
//
//  Created by 김지은 on 2021/09/13.
//

import UIKit

// 섹션 이넘
enum Section {
    case feed, post, board
}

// 클래스
class Feed: Hashable { // hashable: 프로토콜 (사용하는 모델이 클래스일 경우, 사용)
    // 고유아이디
    let uuid: UUID = UUID()
    var content: String
    init(content: String) {
        self.content = content
    }
    
    // 일치하는지 여부 체크 필요
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    //
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

// 스트럭트
struct Post: Hashable {
    var content: String
}

class ViewController: UIViewController {
    
    // 1. 테이블뷰
    @IBOutlet weak var MyTableView: UITableView!
    
    // 2. 데이터소스 - UITableViewDataSource delegate올 대체
    var dataSource: UITableViewDiffableDataSource<Section,Feed>!
    
    // 3. 스냅샷 - 현재의 데이터 상태
    var snapshot: NSDiffableDataSourceSnapshot<Section, Feed>!
    
    let feedArray = [
            Feed(content: "simply dummy text of the printing and"),
            
            Feed(content: "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type "),
            
            Feed(content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribestablished fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
            
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
            
            Feed(content: "established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
            
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
            
            Feed(content: "a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is thaai"),
            
            Feed(content: "ho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it is pai"),
            
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simplho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it y because it is pai"),
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 셀 리소스 파일 가져오기
        // let MyTableViewCellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        let MyTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        // 셀에 리소스 등록하기
        self.MyTableView.register(MyTableViewCellNib, forCellReuseIdentifier: "MyTableViewCell")
        
        self.MyTableView.rowHeight = UITableView.automaticDimension
        self.MyTableView.estimatedRowHeight = 120
        
        // 아주 중요
        self.MyTableView.delegate = self
//        self.MyTableView.dataSource = self
        
        print("contentArray.count = \(feedArray.count)")
        
        // MARK: 데이터 소스 설정
        dataSource = UITableViewDiffableDataSource<Section, Feed> (tableView: MyTableView, cellProvider: {
            (tableView: UITableView, indexPath: IndexPath, identifier: Feed) -> UITableViewCell? in
            
            // cell 클래스 연결
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
            return cell
        })
        
        // 데이터 소스의 현재 스냅샷을 만든다
        snapshot = NSDiffableDataSourceSnapshot<Section, Feed>()
        
        // 섹션을 추가한다
        snapshot.appendSections([.feed])
        
        // 방금 추가한 섹션에 아이템을 넣는다
        snapshot.appendItems(feedArray, toSection: .feed)
        
        // 현재 스냅샷을 화면에 보여준다
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ViewController: UITableViewDelegate {

}

//extension ViewController: UITableViewDataSource {
//
//    // 테이블 뷰 셀의 갯수
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.contentArray.count
//    }
//
//    // 각 셀에 대한 설정
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = MyTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
//
//        cell.UserContentLabel.text = contentArray[indexPath.row]
//
//        return cell
//    }
//}

