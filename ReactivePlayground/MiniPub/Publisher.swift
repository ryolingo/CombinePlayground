//
//  Publisher.swift
//  ReactivePlayground
//
//  Created by matsumotoryota on 2025/11/01.
//

import Foundation

final class Publisher<Value> {
  private var subscribers: [(id: UUID, handler: (Value) -> Void)] = []

  func send(_ value: Value) {
    print("Publisher\(Value.self)send:", value)
    subscribers.forEach { $0.handler(value) }
  }

  func subscribe(_ receiveValue: @escaping (Value) -> Void) -> AnyCancellable {
    let id = UUID()
    subscribers.append((id, receiveValue))
    
    //解除処理をクロージャで返す
    return AnyCancellable { [weak self] in
      self?.subscribers.removeAll{ $0.id == id}
      print("Subscription cancelled")
    }
  }
}

extension Publisher {

  func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Publisher<
    NewValue
  > {
    let newPublisher = Publisher<NewValue>()
    self.subscribe { value in
      print("受け取った")
      let newValue = transform(value)
      print("[Map]変換後:", newValue)
      newPublisher.send(newValue)
      print("")
    }
    return newPublisher
  }

  //filter演算子
  func filter(_ isIncluded: @escaping (Value) -> Bool) -> Publisher<Value> {
    let newPublisher = Publisher<Value>()

    self.subscribe { value in
      print("🔎 [Filter] 受け取った:", value)
      if isIncluded(value) {
        print("Filter通過:", value)
        newPublisher.send(value)
      } else {
        print("除外")
      }
    }
    return newPublisher//←これに対してmapが呼ばれるここはオブジェクト自体を返している部分。
  }
}
