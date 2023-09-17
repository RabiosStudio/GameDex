// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import Foundation
import UIKit
@testable import GameDex


// MARK: - API

open class APIMock: API, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var lastTask: URLSessionTask? {
		get {	invocations.append(.p_lastTask_get); return __p_lastTask ?? optionalGivenGetterValue(.p_lastTask_get, "APIMock - stub value for lastTask was not defined") }
		set {	invocations.append(.p_lastTask_set(.value(newValue))); __p_lastTask = newValue }
	}
	private var __p_lastTask: (URLSessionTask)?

    public var basePath: String {
		get {	invocations.append(.p_basePath_get); return __p_basePath ?? givenGetterValue(.p_basePath_get, "APIMock - stub value for basePath was not defined") }
	}
	private var __p_basePath: (String)?

    public var commonParameters: [String: Any]? {
		get {	invocations.append(.p_commonParameters_get); return __p_commonParameters ?? optionalGivenGetterValue(.p_commonParameters_get, "APIMock - stub value for commonParameters was not defined") }
	}
	private var __p_commonParameters: ([String: Any])?





    open func getData<T: APIEndpoint, U: Decodable>(with endpoint: T) -> Result<U, APIError> {
        addInvocation(.m_getData__with_endpoint(Parameter<T>.value(`endpoint`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_getData__with_endpoint(Parameter<T>.value(`endpoint`).wrapAsGeneric())) as? (T) -> Void
		perform?(`endpoint`)
		var __value: Result<U, APIError>
		do {
		    __value = try methodReturnValue(.m_getData__with_endpoint(Parameter<T>.value(`endpoint`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getData<T: APIEndpoint, U: Decodable>(with endpoint: T). Use given")
			Failure("Stub return value not specified for getData<T: APIEndpoint, U: Decodable>(with endpoint: T). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getData__with_endpoint(Parameter<GenericAttribute>)
        case p_lastTask_get
		case p_lastTask_set(Parameter<URLSessionTask?>)
        case p_basePath_get
        case p_commonParameters_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getData__with_endpoint(let lhsEndpoint), .m_getData__with_endpoint(let rhsEndpoint)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEndpoint, rhs: rhsEndpoint, with: matcher), lhsEndpoint, rhsEndpoint, "with endpoint"))
				return Matcher.ComparisonResult(results)
            case (.p_lastTask_get,.p_lastTask_get): return Matcher.ComparisonResult.match
			case (.p_lastTask_set(let left),.p_lastTask_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<URLSessionTask?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_basePath_get,.p_basePath_get): return Matcher.ComparisonResult.match
            case (.p_commonParameters_get,.p_commonParameters_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getData__with_endpoint(p0): return p0.intValue
            case .p_lastTask_get: return 0
			case .p_lastTask_set(let newValue): return newValue.intValue
            case .p_basePath_get: return 0
            case .p_commonParameters_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getData__with_endpoint: return ".getData(with:)"
            case .p_lastTask_get: return "[get] .lastTask"
			case .p_lastTask_set: return "[set] .lastTask"
            case .p_basePath_get: return "[get] .basePath"
            case .p_commonParameters_get: return "[get] .commonParameters"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func lastTask(getter defaultValue: URLSessionTask?...) -> PropertyStub {
            return Given(method: .p_lastTask_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func basePath(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_basePath_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func commonParameters(getter defaultValue: [String: Any]?...) -> PropertyStub {
            return Given(method: .p_commonParameters_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func getData<T: APIEndpoint, U: Decodable>(with endpoint: Parameter<T>, willReturn: Result<U, APIError>...) -> MethodStub {
            return Given(method: .m_getData__with_endpoint(`endpoint`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getData<T: APIEndpoint, U: Decodable>(with endpoint: Parameter<T>, willProduce: (Stubber<Result<U, APIError>>) -> Void) -> MethodStub {
            let willReturn: [Result<U, APIError>] = []
			let given: Given = { return Given(method: .m_getData__with_endpoint(`endpoint`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<U, APIError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getData<T>(with endpoint: Parameter<T>) -> Verify where T:APIEndpoint { return Verify(method: .m_getData__with_endpoint(`endpoint`.wrapAsGeneric()))}
        public static var lastTask: Verify { return Verify(method: .p_lastTask_get) }
		public static func lastTask(set newValue: Parameter<URLSessionTask?>) -> Verify { return Verify(method: .p_lastTask_set(newValue)) }
        public static var basePath: Verify { return Verify(method: .p_basePath_get) }
        public static var commonParameters: Verify { return Verify(method: .p_commonParameters_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getData<T>(with endpoint: Parameter<T>, perform: @escaping (T) -> Void) -> Perform where T:APIEndpoint {
            return Perform(method: .m_getData__with_endpoint(`endpoint`.wrapAsGeneric()), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - APIEndpoint

open class APIEndpointMock: APIEndpoint, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var path: String {
		get {	invocations.append(.p_path_get); return __p_path ?? givenGetterValue(.p_path_get, "APIEndpointMock - stub value for path was not defined") }
	}
	private var __p_path: (String)?

    public var method: APIMethod {
		get {	invocations.append(.p_method_get); return __p_method ?? givenGetterValue(.p_method_get, "APIEndpointMock - stub value for method was not defined") }
	}
	private var __p_method: (APIMethod)?

    public var entryParameters: [String: Any]? {
		get {	invocations.append(.p_entryParameters_get); return __p_entryParameters ?? optionalGivenGetterValue(.p_entryParameters_get, "APIEndpointMock - stub value for entryParameters was not defined") }
	}
	private var __p_entryParameters: ([String: Any])?






    fileprivate enum MethodType {
        case p_path_get
        case p_method_get
        case p_entryParameters_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {            case (.p_path_get,.p_path_get): return Matcher.ComparisonResult.match
            case (.p_method_get,.p_method_get): return Matcher.ComparisonResult.match
            case (.p_entryParameters_get,.p_entryParameters_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_path_get: return 0
            case .p_method_get: return 0
            case .p_entryParameters_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .p_path_get: return "[get] .path"
            case .p_method_get: return "[get] .method"
            case .p_entryParameters_get: return "[get] .entryParameters"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func path(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_path_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func method(getter defaultValue: APIMethod...) -> PropertyStub {
            return Given(method: .p_method_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func entryParameters(getter defaultValue: [String: Any]?...) -> PropertyStub {
            return Given(method: .p_entryParameters_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var path: Verify { return Verify(method: .p_path_get) }
        public static var method: Verify { return Verify(method: .p_method_get) }
        public static var entryParameters: Verify { return Verify(method: .p_entryParameters_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AddGameDetailsViewModelDelegate

open class AddGameDetailsViewModelDelegateMock: AddGameDetailsViewModelDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func didAddNewGame() {
        addInvocation(.m_didAddNewGame)
		let perform = methodPerformValue(.m_didAddNewGame) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_didAddNewGame

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didAddNewGame, .m_didAddNewGame): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_didAddNewGame: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didAddNewGame: return ".didAddNewGame()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func didAddNewGame() -> Verify { return Verify(method: .m_didAddNewGame)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didAddNewGame(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didAddNewGame, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AlertDisplayer

open class AlertDisplayerMock: AlertDisplayer, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func presentTopFloatAlert(parameters: AlertViewModel) {
        addInvocation(.m_presentTopFloatAlert__parameters_parameters(Parameter<AlertViewModel>.value(`parameters`)))
		let perform = methodPerformValue(.m_presentTopFloatAlert__parameters_parameters(Parameter<AlertViewModel>.value(`parameters`))) as? (AlertViewModel) -> Void
		perform?(`parameters`)
    }

    open func presentBasicAlert(parameters: AlertViewModel) {
        addInvocation(.m_presentBasicAlert__parameters_parameters(Parameter<AlertViewModel>.value(`parameters`)))
		let perform = methodPerformValue(.m_presentBasicAlert__parameters_parameters(Parameter<AlertViewModel>.value(`parameters`))) as? (AlertViewModel) -> Void
		perform?(`parameters`)
    }


    fileprivate enum MethodType {
        case m_presentTopFloatAlert__parameters_parameters(Parameter<AlertViewModel>)
        case m_presentBasicAlert__parameters_parameters(Parameter<AlertViewModel>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_presentTopFloatAlert__parameters_parameters(let lhsParameters), .m_presentTopFloatAlert__parameters_parameters(let rhsParameters)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameters, rhs: rhsParameters, with: matcher), lhsParameters, rhsParameters, "parameters"))
				return Matcher.ComparisonResult(results)

            case (.m_presentBasicAlert__parameters_parameters(let lhsParameters), .m_presentBasicAlert__parameters_parameters(let rhsParameters)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsParameters, rhs: rhsParameters, with: matcher), lhsParameters, rhsParameters, "parameters"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_presentTopFloatAlert__parameters_parameters(p0): return p0.intValue
            case let .m_presentBasicAlert__parameters_parameters(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_presentTopFloatAlert__parameters_parameters: return ".presentTopFloatAlert(parameters:)"
            case .m_presentBasicAlert__parameters_parameters: return ".presentBasicAlert(parameters:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func presentTopFloatAlert(parameters: Parameter<AlertViewModel>) -> Verify { return Verify(method: .m_presentTopFloatAlert__parameters_parameters(`parameters`))}
        public static func presentBasicAlert(parameters: Parameter<AlertViewModel>) -> Verify { return Verify(method: .m_presentBasicAlert__parameters_parameters(`parameters`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func presentTopFloatAlert(parameters: Parameter<AlertViewModel>, perform: @escaping (AlertViewModel) -> Void) -> Perform {
            return Perform(method: .m_presentTopFloatAlert__parameters_parameters(`parameters`), performs: perform)
        }
        public static func presentBasicAlert(parameters: Parameter<AlertViewModel>, perform: @escaping (AlertViewModel) -> Void) -> Perform {
            return Perform(method: .m_presentBasicAlert__parameters_parameters(`parameters`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AlertDisplayerDelegate

open class AlertDisplayerDelegateMock: AlertDisplayerDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func didTapOkButton() {
        addInvocation(.m_didTapOkButton)
		let perform = methodPerformValue(.m_didTapOkButton) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_didTapOkButton

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didTapOkButton, .m_didTapOkButton): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_didTapOkButton: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didTapOkButton: return ".didTapOkButton()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func didTapOkButton() -> Verify { return Verify(method: .m_didTapOkButton)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didTapOkButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapOkButton, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ContainerViewControllerDelegate

open class ContainerViewControllerDelegateMock: ContainerViewControllerDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func configureBottomView(contentViewFactory: ContentViewFactory) {
        addInvocation(.m_configureBottomView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>.value(`contentViewFactory`)))
		let perform = methodPerformValue(.m_configureBottomView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>.value(`contentViewFactory`))) as? (ContentViewFactory) -> Void
		perform?(`contentViewFactory`)
    }

    open func reloadSections() {
        addInvocation(.m_reloadSections)
		let perform = methodPerformValue(.m_reloadSections) as? () -> Void
		perform?()
    }

    open func goBackToRootViewController() {
        addInvocation(.m_goBackToRootViewController)
		let perform = methodPerformValue(.m_goBackToRootViewController) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_configureBottomView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>)
        case m_reloadSections
        case m_goBackToRootViewController

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_configureBottomView__contentViewFactory_contentViewFactory(let lhsContentviewfactory), .m_configureBottomView__contentViewFactory_contentViewFactory(let rhsContentviewfactory)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsContentviewfactory, rhs: rhsContentviewfactory, with: matcher), lhsContentviewfactory, rhsContentviewfactory, "contentViewFactory"))
				return Matcher.ComparisonResult(results)

            case (.m_reloadSections, .m_reloadSections): return .match

            case (.m_goBackToRootViewController, .m_goBackToRootViewController): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_configureBottomView__contentViewFactory_contentViewFactory(p0): return p0.intValue
            case .m_reloadSections: return 0
            case .m_goBackToRootViewController: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_configureBottomView__contentViewFactory_contentViewFactory: return ".configureBottomView(contentViewFactory:)"
            case .m_reloadSections: return ".reloadSections()"
            case .m_goBackToRootViewController: return ".goBackToRootViewController()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func configureBottomView(contentViewFactory: Parameter<ContentViewFactory>) -> Verify { return Verify(method: .m_configureBottomView__contentViewFactory_contentViewFactory(`contentViewFactory`))}
        public static func reloadSections() -> Verify { return Verify(method: .m_reloadSections)}
        public static func goBackToRootViewController() -> Verify { return Verify(method: .m_goBackToRootViewController)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func configureBottomView(contentViewFactory: Parameter<ContentViewFactory>, perform: @escaping (ContentViewFactory) -> Void) -> Perform {
            return Perform(method: .m_configureBottomView__contentViewFactory_contentViewFactory(`contentViewFactory`), performs: perform)
        }
        public static func reloadSections(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reloadSections, performs: perform)
        }
        public static func goBackToRootViewController(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_goBackToRootViewController, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Database

open class DatabaseMock: Database, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func add(newEntity: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        addInvocation(.m_add__newEntity_newEntitycallback_callback(Parameter<SavedGame>.value(`newEntity`), Parameter<(DatabaseError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_add__newEntity_newEntitycallback_callback(Parameter<SavedGame>.value(`newEntity`), Parameter<(DatabaseError?) -> ()>.value(`callback`))) as? (SavedGame, @escaping (DatabaseError?) -> ()) -> Void
		perform?(`newEntity`, `callback`)
    }

    open func fetchAll() -> Result<[GameCollected], DatabaseError> {
        addInvocation(.m_fetchAll)
		let perform = methodPerformValue(.m_fetchAll) as? () -> Void
		perform?()
		var __value: Result<[GameCollected], DatabaseError>
		do {
		    __value = try methodReturnValue(.m_fetchAll).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchAll(). Use given")
			Failure("Stub return value not specified for fetchAll(). Use given")
		}
		return __value
    }

    open func replace(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        addInvocation(.m_replace__savedGame_savedGamecallback_callback(Parameter<SavedGame>.value(`savedGame`), Parameter<(DatabaseError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_replace__savedGame_savedGamecallback_callback(Parameter<SavedGame>.value(`savedGame`), Parameter<(DatabaseError?) -> ()>.value(`callback`))) as? (SavedGame, @escaping (DatabaseError?) -> ()) -> Void
		perform?(`savedGame`, `callback`)
    }

    open func remove(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        addInvocation(.m_remove__savedGame_savedGamecallback_callback(Parameter<SavedGame>.value(`savedGame`), Parameter<(DatabaseError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_remove__savedGame_savedGamecallback_callback(Parameter<SavedGame>.value(`savedGame`), Parameter<(DatabaseError?) -> ()>.value(`callback`))) as? (SavedGame, @escaping (DatabaseError?) -> ()) -> Void
		perform?(`savedGame`, `callback`)
    }


    fileprivate enum MethodType {
        case m_add__newEntity_newEntitycallback_callback(Parameter<SavedGame>, Parameter<(DatabaseError?) -> ()>)
        case m_fetchAll
        case m_replace__savedGame_savedGamecallback_callback(Parameter<SavedGame>, Parameter<(DatabaseError?) -> ()>)
        case m_remove__savedGame_savedGamecallback_callback(Parameter<SavedGame>, Parameter<(DatabaseError?) -> ()>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_add__newEntity_newEntitycallback_callback(let lhsNewentity, let lhsCallback), .m_add__newEntity_newEntitycallback_callback(let rhsNewentity, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewentity, rhs: rhsNewentity, with: matcher), lhsNewentity, rhsNewentity, "newEntity"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchAll, .m_fetchAll): return .match

            case (.m_replace__savedGame_savedGamecallback_callback(let lhsSavedgame, let lhsCallback), .m_replace__savedGame_savedGamecallback_callback(let rhsSavedgame, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_remove__savedGame_savedGamecallback_callback(let lhsSavedgame, let lhsCallback), .m_remove__savedGame_savedGamecallback_callback(let rhsSavedgame, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_add__newEntity_newEntitycallback_callback(p0, p1): return p0.intValue + p1.intValue
            case .m_fetchAll: return 0
            case let .m_replace__savedGame_savedGamecallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_remove__savedGame_savedGamecallback_callback(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_add__newEntity_newEntitycallback_callback: return ".add(newEntity:callback:)"
            case .m_fetchAll: return ".fetchAll()"
            case .m_replace__savedGame_savedGamecallback_callback: return ".replace(savedGame:callback:)"
            case .m_remove__savedGame_savedGamecallback_callback: return ".remove(savedGame:callback:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchAll(willReturn: Result<[GameCollected], DatabaseError>...) -> MethodStub {
            return Given(method: .m_fetchAll, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchAll(willProduce: (Stubber<Result<[GameCollected], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[GameCollected], DatabaseError>] = []
			let given: Given = { return Given(method: .m_fetchAll, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[GameCollected], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func add(newEntity: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_add__newEntity_newEntitycallback_callback(`newEntity`, `callback`))}
        public static func fetchAll() -> Verify { return Verify(method: .m_fetchAll)}
        public static func replace(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_replace__savedGame_savedGamecallback_callback(`savedGame`, `callback`))}
        public static func remove(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_remove__savedGame_savedGamecallback_callback(`savedGame`, `callback`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func add(newEntity: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>, perform: @escaping (SavedGame, @escaping (DatabaseError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_add__newEntity_newEntitycallback_callback(`newEntity`, `callback`), performs: perform)
        }
        public static func fetchAll(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchAll, performs: perform)
        }
        public static func replace(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>, perform: @escaping (SavedGame, @escaping (DatabaseError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_replace__savedGame_savedGamecallback_callback(`savedGame`, `callback`), performs: perform)
        }
        public static func remove(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>, perform: @escaping (SavedGame, @escaping (DatabaseError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_remove__savedGame_savedGamecallback_callback(`savedGame`, `callback`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - EditFormDelegate

open class EditFormDelegateMock: EditFormDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func enableSaveButton() {
        addInvocation(.m_enableSaveButton)
		let perform = methodPerformValue(.m_enableSaveButton) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_enableSaveButton

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_enableSaveButton, .m_enableSaveButton): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_enableSaveButton: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_enableSaveButton: return ".enableSaveButton()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func enableSaveButton() -> Verify { return Verify(method: .m_enableSaveButton)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func enableSaveButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_enableSaveButton, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - PrimaryButtonDelegate

open class PrimaryButtonDelegateMock: PrimaryButtonDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func didTapPrimaryButton() {
        addInvocation(.m_didTapPrimaryButton)
		let perform = methodPerformValue(.m_didTapPrimaryButton) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_didTapPrimaryButton

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didTapPrimaryButton, .m_didTapPrimaryButton): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_didTapPrimaryButton: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didTapPrimaryButton: return ".didTapPrimaryButton()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func didTapPrimaryButton() -> Verify { return Verify(method: .m_didTapPrimaryButton)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didTapPrimaryButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapPrimaryButton, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchViewModelDelegate

open class SearchViewModelDelegateMock: SearchViewModelDelegate, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        addInvocation(.m_updateSearchTextField__with_textcallback_callback(Parameter<String>.value(`text`), Parameter<(EmptyError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_updateSearchTextField__with_textcallback_callback(Parameter<String>.value(`text`), Parameter<(EmptyError?) -> ()>.value(`callback`))) as? (String, @escaping (EmptyError?) -> ()) -> Void
		perform?(`text`, `callback`)
    }

    open func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        addInvocation(.m_startSearch__from_searchQuerycallback_callback(Parameter<String>.value(`searchQuery`), Parameter<(EmptyError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_startSearch__from_searchQuerycallback_callback(Parameter<String>.value(`searchQuery`), Parameter<(EmptyError?) -> ()>.value(`callback`))) as? (String, @escaping (EmptyError?) -> ()) -> Void
		perform?(`searchQuery`, `callback`)
    }


    fileprivate enum MethodType {
        case m_updateSearchTextField__with_textcallback_callback(Parameter<String>, Parameter<(EmptyError?) -> ()>)
        case m_startSearch__from_searchQuerycallback_callback(Parameter<String>, Parameter<(EmptyError?) -> ()>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_updateSearchTextField__with_textcallback_callback(let lhsText, let lhsCallback), .m_updateSearchTextField__with_textcallback_callback(let rhsText, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "with text"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_startSearch__from_searchQuerycallback_callback(let lhsSearchquery, let lhsCallback), .m_startSearch__from_searchQuerycallback_callback(let rhsSearchquery, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchquery, rhs: rhsSearchquery, with: matcher), lhsSearchquery, rhsSearchquery, "from searchQuery"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_updateSearchTextField__with_textcallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_startSearch__from_searchQuerycallback_callback(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_updateSearchTextField__with_textcallback_callback: return ".updateSearchTextField(with:callback:)"
            case .m_startSearch__from_searchQuerycallback_callback: return ".startSearch(from:callback:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func updateSearchTextField(with text: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>) -> Verify { return Verify(method: .m_updateSearchTextField__with_textcallback_callback(`text`, `callback`))}
        public static func startSearch(from searchQuery: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>) -> Verify { return Verify(method: .m_startSearch__from_searchQuerycallback_callback(`searchQuery`, `callback`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func updateSearchTextField(with text: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>, perform: @escaping (String, @escaping (EmptyError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_updateSearchTextField__with_textcallback_callback(`text`, `callback`), performs: perform)
        }
        public static func startSearch(from searchQuery: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>, perform: @escaping (String, @escaping (EmptyError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_startSearch__from_searchQuerycallback_callback(`searchQuery`, `callback`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

