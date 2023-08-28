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


    fileprivate enum MethodType {
        case m_configureBottomView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_configureBottomView__contentViewFactory_contentViewFactory(let lhsContentviewfactory), .m_configureBottomView__contentViewFactory_contentViewFactory(let rhsContentviewfactory)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsContentviewfactory, rhs: rhsContentviewfactory, with: matcher), lhsContentviewfactory, rhsContentviewfactory, "contentViewFactory"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_configureBottomView__contentViewFactory_contentViewFactory(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_configureBottomView__contentViewFactory_contentViewFactory: return ".configureBottomView(contentViewFactory:)"
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
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func configureBottomView(contentViewFactory: Parameter<ContentViewFactory>, perform: @escaping (ContentViewFactory) -> Void) -> Perform {
            return Perform(method: .m_configureBottomView__contentViewFactory_contentViewFactory(`contentViewFactory`), performs: perform)
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





    open func updateSearch(with text: String, callback: @escaping (EmptyError?) -> ()) {
        addInvocation(.m_updateSearch__with_textcallback_callback(Parameter<String>.value(`text`), Parameter<(EmptyError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_updateSearch__with_textcallback_callback(Parameter<String>.value(`text`), Parameter<(EmptyError?) -> ()>.value(`callback`))) as? (String, @escaping (EmptyError?) -> ()) -> Void
		perform?(`text`, `callback`)
    }


    fileprivate enum MethodType {
        case m_updateSearch__with_textcallback_callback(Parameter<String>, Parameter<(EmptyError?) -> ()>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_updateSearch__with_textcallback_callback(let lhsText, let lhsCallback), .m_updateSearch__with_textcallback_callback(let rhsText, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "with text"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_updateSearch__with_textcallback_callback(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_updateSearch__with_textcallback_callback: return ".updateSearch(with:callback:)"
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

        public static func updateSearch(with text: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>) -> Verify { return Verify(method: .m_updateSearch__with_textcallback_callback(`text`, `callback`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func updateSearch(with text: Parameter<String>, callback: Parameter<(EmptyError?) -> ()>, perform: @escaping (String, @escaping (EmptyError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_updateSearch__with_textcallback_callback(`text`, `callback`), performs: perform)
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

