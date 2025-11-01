//
//  Publisher.swift
//  ReactivePlayground
//
//  Created by matsumotoryota on 2025/11/01.
//

import Foundation

final class Publisher<Value> {
  private var subscribers: [(Value) -> Void] = []

  func send(_ value: Value) {
    subscribers.forEach { $0(value) }
  }

  func subscribe(_ receiveValue: @escaping (Value) -> Void) {
    subscribers.append(receiveValue)
  }
}

extension Publisher {

  func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Publisher<
    NewValue
  > {
    let newPublisher = Publisher<NewValue>()
    self.subscribe { value in
      newPublisher.send(transform(value))
    }
    return newPublisher
  }

  //filter演算子
  func filter(_ isIncluded: @escaping (Value) -> Bool) -> Publisher<Value> {
    let newPublisher = Publisher<Value>()

    self.subscribe { value in
      if isIncluded(value) {
        newPublisher.send(value)
      }
    }
    return newPublisher//←これに対してmapが呼ばれるここはオブジェクト自体を返している部分。
  }
}
