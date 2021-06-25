//
// Created by Shaban on 23/06/2021.
//

import Combine


public typealias Relay<T> = CurrentValueSubject<T, Never>
public typealias NeverSubject<T> = PassthroughSubject<T, Never>
public typealias NeverPublisher<T> = AnyPublisher<T, Never>
public typealias Drive<T> = Published<T>.Publisher
public typealias CancelableBag = Set<AnyCancellable>
