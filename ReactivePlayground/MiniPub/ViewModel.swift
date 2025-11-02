//
//  ViewModel.swift
//  ReactivePlayground
//
//  Created by matsumotoryota on 2025/11/01.
//

import Foundation

final class CounterViewModel {
  private var cancellable: AnyCancellable?
  private let publisher = Publisher<String>()
  private var count = 0
  
  func starObserving(_ handler: @escaping(String) -> Void) -> AnyCancellable {
    let cancellable = publisher.subscribe(handler)
    self.cancellable = cancellable
    return cancellable
  }
  
  func increment() {
    count += 1
    if count % 2 == 0 {
      publisher.send("Even number: \(count)")
    }
  }
}
