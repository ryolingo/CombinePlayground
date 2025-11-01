//
//  ViewModel.swift
//  ReactivePlayground
//
//  Created by matsumotoryota on 2025/11/01.
//

import Foundation

final class CounterViewModel {
  private(set) var count = 0
  let publisher = Publisher<Int>()
  
  func increment() {
    count += 1
    publisher.send(count)
  }

  var evenNumberPublisher: Publisher<String> {
    publisher.filter { $0 % 2 == 0}
    .map { "Even Number: \( $0 )"}
  }
}
