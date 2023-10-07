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

    open func setCommonParameters(cloudDatabase: CloudDatabase) {
        addInvocation(.m_setCommonParameters__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>.value(`cloudDatabase`)))
		let perform = methodPerformValue(.m_setCommonParameters__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>.value(`cloudDatabase`))) as? (CloudDatabase) -> Void
		perform?(`cloudDatabase`)
    }


    fileprivate enum MethodType {
        case m_getData__with_endpoint(Parameter<GenericAttribute>)
        case m_setCommonParameters__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>)
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

            case (.m_setCommonParameters__cloudDatabase_cloudDatabase(let lhsClouddatabase), .m_setCommonParameters__cloudDatabase_cloudDatabase(let rhsClouddatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
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
            case let .m_setCommonParameters__cloudDatabase_cloudDatabase(p0): return p0.intValue
            case .p_lastTask_get: return 0
			case .p_lastTask_set(let newValue): return newValue.intValue
            case .p_basePath_get: return 0
            case .p_commonParameters_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getData__with_endpoint: return ".getData(with:)"
            case .m_setCommonParameters__cloudDatabase_cloudDatabase: return ".setCommonParameters(cloudDatabase:)"
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
        public static func setCommonParameters(cloudDatabase: Parameter<CloudDatabase>) -> Verify { return Verify(method: .m_setCommonParameters__cloudDatabase_cloudDatabase(`cloudDatabase`))}
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
        public static func setCommonParameters(cloudDatabase: Parameter<CloudDatabase>, perform: @escaping (CloudDatabase) -> Void) -> Perform {
            return Perform(method: .m_setCommonParameters__cloudDatabase_cloudDatabase(`cloudDatabase`), performs: perform)
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

    public var alertDelegate: AlertDisplayerDelegate? {
		get {	invocations.append(.p_alertDelegate_get); return __p_alertDelegate ?? optionalGivenGetterValue(.p_alertDelegate_get, "AlertDisplayerMock - stub value for alertDelegate was not defined") }
		set {	invocations.append(.p_alertDelegate_set(.value(newValue))); __p_alertDelegate = newValue }
	}
	private var __p_alertDelegate: (AlertDisplayerDelegate)?





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
        case p_alertDelegate_get
		case p_alertDelegate_set(Parameter<AlertDisplayerDelegate?>)

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
            case (.p_alertDelegate_get,.p_alertDelegate_get): return Matcher.ComparisonResult.match
			case (.p_alertDelegate_set(let left),.p_alertDelegate_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AlertDisplayerDelegate?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_presentTopFloatAlert__parameters_parameters(p0): return p0.intValue
            case let .m_presentBasicAlert__parameters_parameters(p0): return p0.intValue
            case .p_alertDelegate_get: return 0
			case .p_alertDelegate_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_presentTopFloatAlert__parameters_parameters: return ".presentTopFloatAlert(parameters:)"
            case .m_presentBasicAlert__parameters_parameters: return ".presentBasicAlert(parameters:)"
            case .p_alertDelegate_get: return "[get] .alertDelegate"
			case .p_alertDelegate_set: return "[set] .alertDelegate"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func alertDelegate(getter defaultValue: AlertDisplayerDelegate?...) -> PropertyStub {
            return Given(method: .p_alertDelegate_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func presentTopFloatAlert(parameters: Parameter<AlertViewModel>) -> Verify { return Verify(method: .m_presentTopFloatAlert__parameters_parameters(`parameters`))}
        public static func presentBasicAlert(parameters: Parameter<AlertViewModel>) -> Verify { return Verify(method: .m_presentBasicAlert__parameters_parameters(`parameters`))}
        public static var alertDelegate: Verify { return Verify(method: .p_alertDelegate_get) }
		public static func alertDelegate(set newValue: Parameter<AlertDisplayerDelegate?>) -> Verify { return Verify(method: .p_alertDelegate_set(newValue)) }
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

// MARK: - AuthenticationService

open class AuthenticationServiceMock: AuthenticationService, Mock {
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





    open func login(email: String, password: String, callback: @escaping (AuthenticationError?) -> ()) {
        addInvocation(.m_login__email_emailpassword_passwordcallback_callback(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<(AuthenticationError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_login__email_emailpassword_passwordcallback_callback(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<(AuthenticationError?) -> ()>.value(`callback`))) as? (String, String, @escaping (AuthenticationError?) -> ()) -> Void
		perform?(`email`, `password`, `callback`)
    }

    open func createUser(email: String, password: String, cloudDatabase: CloudDatabase) -> AuthenticationError? {
        addInvocation(.m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`)))
		let perform = methodPerformValue(.m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`))) as? (String, String, CloudDatabase) -> Void
		perform?(`email`, `password`, `cloudDatabase`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func logout(callback: @escaping (AuthenticationError?) -> ()) {
        addInvocation(.m_logout__callback_callback(Parameter<(AuthenticationError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_logout__callback_callback(Parameter<(AuthenticationError?) -> ()>.value(`callback`))) as? (@escaping (AuthenticationError?) -> ()) -> Void
		perform?(`callback`)
    }

    open func userIsLoggedIn() -> Bool {
        addInvocation(.m_userIsLoggedIn)
		let perform = methodPerformValue(.m_userIsLoggedIn) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_userIsLoggedIn).casted()
		} catch {
			onFatalFailure("Stub return value not specified for userIsLoggedIn(). Use given")
			Failure("Stub return value not specified for userIsLoggedIn(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_login__email_emailpassword_passwordcallback_callback(Parameter<String>, Parameter<String>, Parameter<(AuthenticationError?) -> ()>)
        case m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(Parameter<String>, Parameter<String>, Parameter<CloudDatabase>)
        case m_logout__callback_callback(Parameter<(AuthenticationError?) -> ()>)
        case m_userIsLoggedIn

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_login__email_emailpassword_passwordcallback_callback(let lhsEmail, let lhsPassword, let lhsCallback), .m_login__email_emailpassword_passwordcallback_callback(let rhsEmail, let rhsPassword, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(let lhsEmail, let lhsPassword, let lhsClouddatabase), .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(let rhsEmail, let rhsPassword, let rhsClouddatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_logout__callback_callback(let lhsCallback), .m_logout__callback_callback(let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_userIsLoggedIn, .m_userIsLoggedIn): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_login__email_emailpassword_passwordcallback_callback(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_logout__callback_callback(p0): return p0.intValue
            case .m_userIsLoggedIn: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_login__email_emailpassword_passwordcallback_callback: return ".login(email:password:callback:)"
            case .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase: return ".createUser(email:password:cloudDatabase:)"
            case .m_logout__callback_callback: return ".logout(callback:)"
            case .m_userIsLoggedIn: return ".userIsLoggedIn()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func userIsLoggedIn(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_userIsLoggedIn, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func userIsLoggedIn(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_userIsLoggedIn, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func login(email: Parameter<String>, password: Parameter<String>, callback: Parameter<(AuthenticationError?) -> ()>) -> Verify { return Verify(method: .m_login__email_emailpassword_passwordcallback_callback(`email`, `password`, `callback`))}
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>) -> Verify { return Verify(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`))}
        public static func logout(callback: Parameter<(AuthenticationError?) -> ()>) -> Verify { return Verify(method: .m_logout__callback_callback(`callback`))}
        public static func userIsLoggedIn() -> Verify { return Verify(method: .m_userIsLoggedIn)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func login(email: Parameter<String>, password: Parameter<String>, callback: Parameter<(AuthenticationError?) -> ()>, perform: @escaping (String, String, @escaping (AuthenticationError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_login__email_emailpassword_passwordcallback_callback(`email`, `password`, `callback`), performs: perform)
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, perform: @escaping (String, String, CloudDatabase) -> Void) -> Perform {
            return Perform(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), performs: perform)
        }
        public static func logout(callback: Parameter<(AuthenticationError?) -> ()>, perform: @escaping (@escaping (AuthenticationError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_logout__callback_callback(`callback`), performs: perform)
        }
        public static func userIsLoggedIn(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userIsLoggedIn, performs: perform)
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

// MARK: - CloudDatabase

open class CloudDatabaseMock: CloudDatabase, Mock {
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





    open func getAvailablePlatforms() -> Result<[Platform], DatabaseError> {
        addInvocation(.m_getAvailablePlatforms)
		let perform = methodPerformValue(.m_getAvailablePlatforms) as? () -> Void
		perform?()
		var __value: Result<[Platform], DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getAvailablePlatforms).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getAvailablePlatforms(). Use given")
			Failure("Stub return value not specified for getAvailablePlatforms(). Use given")
		}
		return __value
    }

    open func saveUser(userEmail: String) -> DatabaseError? {
        addInvocation(.m_saveUser__userEmail_userEmail(Parameter<String>.value(`userEmail`)))
		let perform = methodPerformValue(.m_saveUser__userEmail_userEmail(Parameter<String>.value(`userEmail`))) as? (String) -> Void
		perform?(`userEmail`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveUser__userEmail_userEmail(Parameter<String>.value(`userEmail`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveGame(userEmail: String, platform: Platform, localDatabase: LocalDatabase) -> DatabaseError? {
        addInvocation(.m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<Platform>.value(`platform`), Parameter<LocalDatabase>.value(`localDatabase`)))
		let perform = methodPerformValue(.m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<Platform>.value(`platform`), Parameter<LocalDatabase>.value(`localDatabase`))) as? (String, Platform, LocalDatabase) -> Void
		perform?(`userEmail`, `platform`, `localDatabase`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<Platform>.value(`platform`), Parameter<LocalDatabase>.value(`localDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveCollection(userEmail: String, localDatabase: LocalDatabase) -> DatabaseError? {
        addInvocation(.m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<LocalDatabase>.value(`localDatabase`)))
		let perform = methodPerformValue(.m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<LocalDatabase>.value(`localDatabase`))) as? (String, LocalDatabase) -> Void
		perform?(`userEmail`, `localDatabase`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(Parameter<String>.value(`userEmail`), Parameter<LocalDatabase>.value(`localDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func getApiKey() -> Result<String, DatabaseError> {
        addInvocation(.m_getApiKey)
		let perform = methodPerformValue(.m_getApiKey) as? () -> Void
		perform?()
		var __value: Result<String, DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getApiKey).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getApiKey(). Use given")
			Failure("Stub return value not specified for getApiKey(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getAvailablePlatforms
        case m_saveUser__userEmail_userEmail(Parameter<String>)
        case m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(Parameter<String>, Parameter<Platform>, Parameter<LocalDatabase>)
        case m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(Parameter<String>, Parameter<LocalDatabase>)
        case m_getApiKey

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getAvailablePlatforms, .m_getAvailablePlatforms): return .match

            case (.m_saveUser__userEmail_userEmail(let lhsUseremail), .m_saveUser__userEmail_userEmail(let rhsUseremail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				return Matcher.ComparisonResult(results)

            case (.m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(let lhsUseremail, let lhsPlatform, let lhsLocaldatabase), .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(let rhsUseremail, let rhsPlatform, let rhsLocaldatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocaldatabase, rhs: rhsLocaldatabase, with: matcher), lhsLocaldatabase, rhsLocaldatabase, "localDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(let lhsUseremail, let lhsLocaldatabase), .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(let rhsUseremail, let rhsLocaldatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocaldatabase, rhs: rhsLocaldatabase, with: matcher), lhsLocaldatabase, rhsLocaldatabase, "localDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_getApiKey, .m_getApiKey): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getAvailablePlatforms: return 0
            case let .m_saveUser__userEmail_userEmail(p0): return p0.intValue
            case let .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(p0, p1): return p0.intValue + p1.intValue
            case .m_getApiKey: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getAvailablePlatforms: return ".getAvailablePlatforms()"
            case .m_saveUser__userEmail_userEmail: return ".saveUser(userEmail:)"
            case .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase: return ".saveGame(userEmail:platform:localDatabase:)"
            case .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase: return ".saveCollection(userEmail:localDatabase:)"
            case .m_getApiKey: return ".getApiKey()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getAvailablePlatforms(willReturn: Result<[Platform], DatabaseError>...) -> MethodStub {
            return Given(method: .m_getAvailablePlatforms, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveUser(userEmail: Parameter<String>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveUser__userEmail_userEmail(`userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveGame(userEmail: Parameter<String>, platform: Parameter<Platform>, localDatabase: Parameter<LocalDatabase>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(`userEmail`, `platform`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveCollection(userEmail: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(`userEmail`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getApiKey(willReturn: Result<String, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getApiKey, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getAvailablePlatforms(willProduce: (Stubber<Result<[Platform], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[Platform], DatabaseError>] = []
			let given: Given = { return Given(method: .m_getAvailablePlatforms, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[Platform], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func saveUser(userEmail: Parameter<String>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveUser__userEmail_userEmail(`userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveGame(userEmail: Parameter<String>, platform: Parameter<Platform>, localDatabase: Parameter<LocalDatabase>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(`userEmail`, `platform`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveCollection(userEmail: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(`userEmail`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func getApiKey(willProduce: (Stubber<Result<String, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<String, DatabaseError>] = []
			let given: Given = { return Given(method: .m_getApiKey, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<String, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getAvailablePlatforms() -> Verify { return Verify(method: .m_getAvailablePlatforms)}
        public static func saveUser(userEmail: Parameter<String>) -> Verify { return Verify(method: .m_saveUser__userEmail_userEmail(`userEmail`))}
        public static func saveGame(userEmail: Parameter<String>, platform: Parameter<Platform>, localDatabase: Parameter<LocalDatabase>) -> Verify { return Verify(method: .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(`userEmail`, `platform`, `localDatabase`))}
        public static func saveCollection(userEmail: Parameter<String>, localDatabase: Parameter<LocalDatabase>) -> Verify { return Verify(method: .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(`userEmail`, `localDatabase`))}
        public static func getApiKey() -> Verify { return Verify(method: .m_getApiKey)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getAvailablePlatforms(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAvailablePlatforms, performs: perform)
        }
        public static func saveUser(userEmail: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_saveUser__userEmail_userEmail(`userEmail`), performs: perform)
        }
        public static func saveGame(userEmail: Parameter<String>, platform: Parameter<Platform>, localDatabase: Parameter<LocalDatabase>, perform: @escaping (String, Platform, LocalDatabase) -> Void) -> Perform {
            return Perform(method: .m_saveGame__userEmail_userEmailplatform_platformlocalDatabase_localDatabase(`userEmail`, `platform`, `localDatabase`), performs: perform)
        }
        public static func saveCollection(userEmail: Parameter<String>, localDatabase: Parameter<LocalDatabase>, perform: @escaping (String, LocalDatabase) -> Void) -> Perform {
            return Perform(method: .m_saveCollection__userEmail_userEmaillocalDatabase_localDatabase(`userEmail`, `localDatabase`), performs: perform)
        }
        public static func getApiKey(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getApiKey, performs: perform)
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





    open func configureSupplementaryView(contentViewFactory: ContentViewFactory, topView: Bool) {
        addInvocation(.m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(Parameter<ContentViewFactory>.value(`contentViewFactory`), Parameter<Bool>.value(`topView`)))
		let perform = methodPerformValue(.m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(Parameter<ContentViewFactory>.value(`contentViewFactory`), Parameter<Bool>.value(`topView`))) as? (ContentViewFactory, Bool) -> Void
		perform?(`contentViewFactory`, `topView`)
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
        case m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(Parameter<ContentViewFactory>, Parameter<Bool>)
        case m_reloadSections
        case m_goBackToRootViewController

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(let lhsContentviewfactory, let lhsTopview), .m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(let rhsContentviewfactory, let rhsTopview)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsContentviewfactory, rhs: rhsContentviewfactory, with: matcher), lhsContentviewfactory, rhsContentviewfactory, "contentViewFactory"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTopview, rhs: rhsTopview, with: matcher), lhsTopview, rhsTopview, "topView"))
				return Matcher.ComparisonResult(results)

            case (.m_reloadSections, .m_reloadSections): return .match

            case (.m_goBackToRootViewController, .m_goBackToRootViewController): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(p0, p1): return p0.intValue + p1.intValue
            case .m_reloadSections: return 0
            case .m_goBackToRootViewController: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView: return ".configureSupplementaryView(contentViewFactory:topView:)"
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

        public static func configureSupplementaryView(contentViewFactory: Parameter<ContentViewFactory>, topView: Parameter<Bool>) -> Verify { return Verify(method: .m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(`contentViewFactory`, `topView`))}
        public static func reloadSections() -> Verify { return Verify(method: .m_reloadSections)}
        public static func goBackToRootViewController() -> Verify { return Verify(method: .m_goBackToRootViewController)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func configureSupplementaryView(contentViewFactory: Parameter<ContentViewFactory>, topView: Parameter<Bool>, perform: @escaping (ContentViewFactory, Bool) -> Void) -> Perform {
            return Perform(method: .m_configureSupplementaryView__contentViewFactory_contentViewFactorytopView_topView(`contentViewFactory`, `topView`), performs: perform)
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





    open func enableSaveButtonIfNeeded() {
        addInvocation(.m_enableSaveButtonIfNeeded)
		let perform = methodPerformValue(.m_enableSaveButtonIfNeeded) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_enableSaveButtonIfNeeded

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_enableSaveButtonIfNeeded, .m_enableSaveButtonIfNeeded): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_enableSaveButtonIfNeeded: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_enableSaveButtonIfNeeded: return ".enableSaveButtonIfNeeded()"
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

        public static func enableSaveButtonIfNeeded() -> Verify { return Verify(method: .m_enableSaveButtonIfNeeded)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func enableSaveButtonIfNeeded(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_enableSaveButtonIfNeeded, performs: perform)
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

// MARK: - LocalDatabase

open class LocalDatabaseMock: LocalDatabase, Mock {
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





    open func add(newEntity: SavedGame, platform: Platform, callback: @escaping (DatabaseError?) -> ()) {
        addInvocation(.m_add__newEntity_newEntityplatform_platformcallback_callback(Parameter<SavedGame>.value(`newEntity`), Parameter<Platform>.value(`platform`), Parameter<(DatabaseError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_add__newEntity_newEntityplatform_platformcallback_callback(Parameter<SavedGame>.value(`newEntity`), Parameter<Platform>.value(`platform`), Parameter<(DatabaseError?) -> ()>.value(`callback`))) as? (SavedGame, Platform, @escaping (DatabaseError?) -> ()) -> Void
		perform?(`newEntity`, `platform`, `callback`)
    }

    open func getPlatform(platformId: Int) -> Result<PlatformCollected?, DatabaseError> {
        addInvocation(.m_getPlatform__platformId_platformId(Parameter<Int>.value(`platformId`)))
		let perform = methodPerformValue(.m_getPlatform__platformId_platformId(Parameter<Int>.value(`platformId`))) as? (Int) -> Void
		perform?(`platformId`)
		var __value: Result<PlatformCollected?, DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getPlatform__platformId_platformId(Parameter<Int>.value(`platformId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getPlatform(platformId: Int). Use given")
			Failure("Stub return value not specified for getPlatform(platformId: Int). Use given")
		}
		return __value
    }

    open func fetchAllPlatforms() -> Result<[PlatformCollected], DatabaseError> {
        addInvocation(.m_fetchAllPlatforms)
		let perform = methodPerformValue(.m_fetchAllPlatforms) as? () -> Void
		perform?()
		var __value: Result<[PlatformCollected], DatabaseError>
		do {
		    __value = try methodReturnValue(.m_fetchAllPlatforms).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchAllPlatforms(). Use given")
			Failure("Stub return value not specified for fetchAllPlatforms(). Use given")
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
        case m_add__newEntity_newEntityplatform_platformcallback_callback(Parameter<SavedGame>, Parameter<Platform>, Parameter<(DatabaseError?) -> ()>)
        case m_getPlatform__platformId_platformId(Parameter<Int>)
        case m_fetchAllPlatforms
        case m_replace__savedGame_savedGamecallback_callback(Parameter<SavedGame>, Parameter<(DatabaseError?) -> ()>)
        case m_remove__savedGame_savedGamecallback_callback(Parameter<SavedGame>, Parameter<(DatabaseError?) -> ()>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_add__newEntity_newEntityplatform_platformcallback_callback(let lhsNewentity, let lhsPlatform, let lhsCallback), .m_add__newEntity_newEntityplatform_platformcallback_callback(let rhsNewentity, let rhsPlatform, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewentity, rhs: rhsNewentity, with: matcher), lhsNewentity, rhsNewentity, "newEntity"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_getPlatform__platformId_platformId(let lhsPlatformid), .m_getPlatform__platformId_platformId(let rhsPlatformid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatformid, rhs: rhsPlatformid, with: matcher), lhsPlatformid, rhsPlatformid, "platformId"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchAllPlatforms, .m_fetchAllPlatforms): return .match

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
            case let .m_add__newEntity_newEntityplatform_platformcallback_callback(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getPlatform__platformId_platformId(p0): return p0.intValue
            case .m_fetchAllPlatforms: return 0
            case let .m_replace__savedGame_savedGamecallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_remove__savedGame_savedGamecallback_callback(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_add__newEntity_newEntityplatform_platformcallback_callback: return ".add(newEntity:platform:callback:)"
            case .m_getPlatform__platformId_platformId: return ".getPlatform(platformId:)"
            case .m_fetchAllPlatforms: return ".fetchAllPlatforms()"
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


        public static func getPlatform(platformId: Parameter<Int>, willReturn: Result<PlatformCollected?, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getPlatform__platformId_platformId(`platformId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchAllPlatforms(willReturn: Result<[PlatformCollected], DatabaseError>...) -> MethodStub {
            return Given(method: .m_fetchAllPlatforms, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPlatform(platformId: Parameter<Int>, willProduce: (Stubber<Result<PlatformCollected?, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<PlatformCollected?, DatabaseError>] = []
			let given: Given = { return Given(method: .m_getPlatform__platformId_platformId(`platformId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<PlatformCollected?, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func fetchAllPlatforms(willProduce: (Stubber<Result<[PlatformCollected], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[PlatformCollected], DatabaseError>] = []
			let given: Given = { return Given(method: .m_fetchAllPlatforms, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[PlatformCollected], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_add__newEntity_newEntityplatform_platformcallback_callback(`newEntity`, `platform`, `callback`))}
        public static func getPlatform(platformId: Parameter<Int>) -> Verify { return Verify(method: .m_getPlatform__platformId_platformId(`platformId`))}
        public static func fetchAllPlatforms() -> Verify { return Verify(method: .m_fetchAllPlatforms)}
        public static func replace(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_replace__savedGame_savedGamecallback_callback(`savedGame`, `callback`))}
        public static func remove(savedGame: Parameter<SavedGame>, callback: Parameter<(DatabaseError?) -> ()>) -> Verify { return Verify(method: .m_remove__savedGame_savedGamecallback_callback(`savedGame`, `callback`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>, callback: Parameter<(DatabaseError?) -> ()>, perform: @escaping (SavedGame, Platform, @escaping (DatabaseError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_add__newEntity_newEntityplatform_platformcallback_callback(`newEntity`, `platform`, `callback`), performs: perform)
        }
        public static func getPlatform(platformId: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getPlatform__platformId_platformId(`platformId`), performs: perform)
        }
        public static func fetchAllPlatforms(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchAllPlatforms, performs: perform)
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

// MARK: - MyCollectionViewModelDelegate

open class MyCollectionViewModelDelegateMock: MyCollectionViewModelDelegate, Mock {
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





    open func reloadCollection() {
        addInvocation(.m_reloadCollection)
		let perform = methodPerformValue(.m_reloadCollection) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_reloadCollection

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_reloadCollection, .m_reloadCollection): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_reloadCollection: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_reloadCollection: return ".reloadCollection()"
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

        public static func reloadCollection() -> Verify { return Verify(method: .m_reloadCollection)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func reloadCollection(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reloadCollection, performs: perform)
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

// MARK: - MyProfileViewModelDelegate

open class MyProfileViewModelDelegateMock: MyProfileViewModelDelegate, Mock {
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





    open func reloadMyProfile() {
        addInvocation(.m_reloadMyProfile)
		let perform = methodPerformValue(.m_reloadMyProfile) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_reloadMyProfile

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_reloadMyProfile, .m_reloadMyProfile): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_reloadMyProfile: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_reloadMyProfile: return ".reloadMyProfile()"
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

        public static func reloadMyProfile() -> Verify { return Verify(method: .m_reloadMyProfile)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func reloadMyProfile(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reloadMyProfile, performs: perform)
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

