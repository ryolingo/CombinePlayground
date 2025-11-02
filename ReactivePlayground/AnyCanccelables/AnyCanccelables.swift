//
//  AnyCanccelables.swift
//  ReactivePlayground
//
//  Created by matsumotoryota on 2025/11/02.
//

import Foundation

protocol Cancellable {
  func cancel()
}

final class AnyCancellable: Cancellable {
  private let onCancel: () -> Void
  private var isCancelled: Bool = false
  
  init(_ onCancel: @escaping () -> Void ) {
    self.onCancel = onCancel
  }
  
  func cancel() {
    guard !isCancelled else { return }
    isCancelled = true
    onCancel()
  }
}
