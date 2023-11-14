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

// MARK: - AppLauncher

open class AppLauncherMock: AppLauncher, Mock {
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





    open func canOpenURL(_ url: URL) -> Bool {
        addInvocation(.m_canOpenURL__url(Parameter<URL>.value(`url`)))
		let perform = methodPerformValue(.m_canOpenURL__url(Parameter<URL>.value(`url`))) as? (URL) -> Void
		perform?(`url`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_canOpenURL__url(Parameter<URL>.value(`url`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for canOpenURL(_ url: URL). Use given")
			Failure("Stub return value not specified for canOpenURL(_ url: URL). Use given")
		}
		return __value
    }

    open func open(_ url: URL) {
        addInvocation(.m_open__url(Parameter<URL>.value(`url`)))
		let perform = methodPerformValue(.m_open__url(Parameter<URL>.value(`url`))) as? (URL) -> Void
		perform?(`url`)
    }

    open func createEmailUrl(to: String) -> URL? {
        addInvocation(.m_createEmailUrl__to_to(Parameter<String>.value(`to`)))
		let perform = methodPerformValue(.m_createEmailUrl__to_to(Parameter<String>.value(`to`))) as? (String) -> Void
		perform?(`to`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_createEmailUrl__to_to(Parameter<String>.value(`to`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_canOpenURL__url(Parameter<URL>)
        case m_open__url(Parameter<URL>)
        case m_createEmailUrl__to_to(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_canOpenURL__url(let lhsUrl), .m_canOpenURL__url(let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "_ url"))
				return Matcher.ComparisonResult(results)

            case (.m_open__url(let lhsUrl), .m_open__url(let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "_ url"))
				return Matcher.ComparisonResult(results)

            case (.m_createEmailUrl__to_to(let lhsTo), .m_createEmailUrl__to_to(let rhsTo)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTo, rhs: rhsTo, with: matcher), lhsTo, rhsTo, "to"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_canOpenURL__url(p0): return p0.intValue
            case let .m_open__url(p0): return p0.intValue
            case let .m_createEmailUrl__to_to(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_canOpenURL__url: return ".canOpenURL(_:)"
            case .m_open__url: return ".open(_:)"
            case .m_createEmailUrl__to_to: return ".createEmailUrl(to:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func canOpenURL(_ url: Parameter<URL>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_canOpenURL__url(`url`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createEmailUrl(to: Parameter<String>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_createEmailUrl__to_to(`to`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func canOpenURL(_ url: Parameter<URL>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_canOpenURL__url(`url`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func createEmailUrl(to: Parameter<String>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_createEmailUrl__to_to(`to`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func canOpenURL(_ url: Parameter<URL>) -> Verify { return Verify(method: .m_canOpenURL__url(`url`))}
        public static func open(_ url: Parameter<URL>) -> Verify { return Verify(method: .m_open__url(`url`))}
        public static func createEmailUrl(to: Parameter<String>) -> Verify { return Verify(method: .m_createEmailUrl__to_to(`to`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func canOpenURL(_ url: Parameter<URL>, perform: @escaping (URL) -> Void) -> Perform {
            return Perform(method: .m_canOpenURL__url(`url`), performs: perform)
        }
        public static func open(_ url: Parameter<URL>, perform: @escaping (URL) -> Void) -> Perform {
            return Perform(method: .m_open__url(`url`), performs: perform)
        }
        public static func createEmailUrl(to: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_createEmailUrl__to_to(`to`), performs: perform)
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

// MARK: - AuthSession

open class AuthSessionMock: AuthSession, Mock {
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





    open func logIn(email: String, password: String) -> AuthenticationError? {
        addInvocation(.m_logIn__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`)))
		let perform = methodPerformValue(.m_logIn__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))) as? (String, String) -> Void
		perform?(`email`, `password`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_logIn__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func createUser(email: String, password: String) -> AuthenticationError? {
        addInvocation(.m_createUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`)))
		let perform = methodPerformValue(.m_createUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))) as? (String, String) -> Void
		perform?(`email`, `password`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_createUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func logOut() -> AuthenticationError? {
        addInvocation(.m_logOut)
		let perform = methodPerformValue(.m_logOut) as? () -> Void
		perform?()
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_logOut).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func getUserUid() -> String? {
        addInvocation(.m_getUserUid)
		let perform = methodPerformValue(.m_getUserUid) as? () -> Void
		perform?()
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_getUserUid).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func updateUserEmailAddress(to newEmail: String) -> AuthenticationError? {
        addInvocation(.m_updateUserEmailAddress__to_newEmail(Parameter<String>.value(`newEmail`)))
		let perform = methodPerformValue(.m_updateUserEmailAddress__to_newEmail(Parameter<String>.value(`newEmail`))) as? (String) -> Void
		perform?(`newEmail`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_updateUserEmailAddress__to_newEmail(Parameter<String>.value(`newEmail`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func updateUserPassword(to newPassword: String) -> AuthenticationError? {
        addInvocation(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`)))
		let perform = methodPerformValue(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`))) as? (String) -> Void
		perform?(`newPassword`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func reauthenticate(email: String, password: String) -> AuthenticationError? {
        addInvocation(.m_reauthenticate__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`)))
		let perform = methodPerformValue(.m_reauthenticate__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))) as? (String, String) -> Void
		perform?(`email`, `password`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_reauthenticate__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func deleteUser() -> AuthenticationError? {
        addInvocation(.m_deleteUser)
		let perform = methodPerformValue(.m_deleteUser) as? () -> Void
		perform?()
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_deleteUser).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func sendPasswordResetEmail(email: String) -> AuthenticationError? {
        addInvocation(.m_sendPasswordResetEmail__email_email(Parameter<String>.value(`email`)))
		let perform = methodPerformValue(.m_sendPasswordResetEmail__email_email(Parameter<String>.value(`email`))) as? (String) -> Void
		perform?(`email`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_sendPasswordResetEmail__email_email(Parameter<String>.value(`email`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_logIn__email_emailpassword_password(Parameter<String>, Parameter<String>)
        case m_createUser__email_emailpassword_password(Parameter<String>, Parameter<String>)
        case m_logOut
        case m_getUserUid
        case m_updateUserEmailAddress__to_newEmail(Parameter<String>)
        case m_updateUserPassword__to_newPassword(Parameter<String>)
        case m_reauthenticate__email_emailpassword_password(Parameter<String>, Parameter<String>)
        case m_deleteUser
        case m_sendPasswordResetEmail__email_email(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_logIn__email_emailpassword_password(let lhsEmail, let lhsPassword), .m_logIn__email_emailpassword_password(let rhsEmail, let rhsPassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				return Matcher.ComparisonResult(results)

            case (.m_createUser__email_emailpassword_password(let lhsEmail, let lhsPassword), .m_createUser__email_emailpassword_password(let rhsEmail, let rhsPassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				return Matcher.ComparisonResult(results)

            case (.m_logOut, .m_logOut): return .match

            case (.m_getUserUid, .m_getUserUid): return .match

            case (.m_updateUserEmailAddress__to_newEmail(let lhsNewemail), .m_updateUserEmailAddress__to_newEmail(let rhsNewemail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewemail, rhs: rhsNewemail, with: matcher), lhsNewemail, rhsNewemail, "to newEmail"))
				return Matcher.ComparisonResult(results)

            case (.m_updateUserPassword__to_newPassword(let lhsNewpassword), .m_updateUserPassword__to_newPassword(let rhsNewpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewpassword, rhs: rhsNewpassword, with: matcher), lhsNewpassword, rhsNewpassword, "to newPassword"))
				return Matcher.ComparisonResult(results)

            case (.m_reauthenticate__email_emailpassword_password(let lhsEmail, let lhsPassword), .m_reauthenticate__email_emailpassword_password(let rhsEmail, let rhsPassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteUser, .m_deleteUser): return .match

            case (.m_sendPasswordResetEmail__email_email(let lhsEmail), .m_sendPasswordResetEmail__email_email(let rhsEmail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_logIn__email_emailpassword_password(p0, p1): return p0.intValue + p1.intValue
            case let .m_createUser__email_emailpassword_password(p0, p1): return p0.intValue + p1.intValue
            case .m_logOut: return 0
            case .m_getUserUid: return 0
            case let .m_updateUserEmailAddress__to_newEmail(p0): return p0.intValue
            case let .m_updateUserPassword__to_newPassword(p0): return p0.intValue
            case let .m_reauthenticate__email_emailpassword_password(p0, p1): return p0.intValue + p1.intValue
            case .m_deleteUser: return 0
            case let .m_sendPasswordResetEmail__email_email(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_logIn__email_emailpassword_password: return ".logIn(email:password:)"
            case .m_createUser__email_emailpassword_password: return ".createUser(email:password:)"
            case .m_logOut: return ".logOut()"
            case .m_getUserUid: return ".getUserUid()"
            case .m_updateUserEmailAddress__to_newEmail: return ".updateUserEmailAddress(to:)"
            case .m_updateUserPassword__to_newPassword: return ".updateUserPassword(to:)"
            case .m_reauthenticate__email_emailpassword_password: return ".reauthenticate(email:password:)"
            case .m_deleteUser: return ".deleteUser()"
            case .m_sendPasswordResetEmail__email_email: return ".sendPasswordResetEmail(email:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func logIn(email: Parameter<String>, password: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_logIn__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_createUser__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func logOut(willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_logOut, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getUserUid(willReturn: String?...) -> MethodStub {
            return Given(method: .m_getUserUid, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_updateUserEmailAddress__to_newEmail(`newEmail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_updateUserPassword__to_newPassword(`newPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func reauthenticate(email: Parameter<String>, password: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_reauthenticate__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func deleteUser(willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_deleteUser, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendPasswordResetEmail(email: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_sendPasswordResetEmail__email_email(`email`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func logIn(email: Parameter<String>, password: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_logIn__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_createUser__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func logOut(willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_logOut, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func getUserUid(willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_getUserUid, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_updateUserEmailAddress__to_newEmail(`newEmail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_updateUserPassword__to_newPassword(`newPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func reauthenticate(email: Parameter<String>, password: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_reauthenticate__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func deleteUser(willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_deleteUser, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func sendPasswordResetEmail(email: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_sendPasswordResetEmail__email_email(`email`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func logIn(email: Parameter<String>, password: Parameter<String>) -> Verify { return Verify(method: .m_logIn__email_emailpassword_password(`email`, `password`))}
        public static func createUser(email: Parameter<String>, password: Parameter<String>) -> Verify { return Verify(method: .m_createUser__email_emailpassword_password(`email`, `password`))}
        public static func logOut() -> Verify { return Verify(method: .m_logOut)}
        public static func getUserUid() -> Verify { return Verify(method: .m_getUserUid)}
        public static func updateUserEmailAddress(to newEmail: Parameter<String>) -> Verify { return Verify(method: .m_updateUserEmailAddress__to_newEmail(`newEmail`))}
        public static func updateUserPassword(to newPassword: Parameter<String>) -> Verify { return Verify(method: .m_updateUserPassword__to_newPassword(`newPassword`))}
        public static func reauthenticate(email: Parameter<String>, password: Parameter<String>) -> Verify { return Verify(method: .m_reauthenticate__email_emailpassword_password(`email`, `password`))}
        public static func deleteUser() -> Verify { return Verify(method: .m_deleteUser)}
        public static func sendPasswordResetEmail(email: Parameter<String>) -> Verify { return Verify(method: .m_sendPasswordResetEmail__email_email(`email`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func logIn(email: Parameter<String>, password: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_logIn__email_emailpassword_password(`email`, `password`), performs: perform)
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_createUser__email_emailpassword_password(`email`, `password`), performs: perform)
        }
        public static func logOut(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_logOut, performs: perform)
        }
        public static func getUserUid(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getUserUid, performs: perform)
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_updateUserEmailAddress__to_newEmail(`newEmail`), performs: perform)
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_updateUserPassword__to_newPassword(`newPassword`), performs: perform)
        }
        public static func reauthenticate(email: Parameter<String>, password: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_reauthenticate__email_emailpassword_password(`email`, `password`), performs: perform)
        }
        public static func deleteUser(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_deleteUser, performs: perform)
        }
        public static func sendPasswordResetEmail(email: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_sendPasswordResetEmail__email_email(`email`), performs: perform)
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





    open func login(email: String, password: String, cloudDatabase: CloudDatabase, localDatabase: LocalDatabase) -> AuthenticationError? {
        addInvocation(.m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`), Parameter<LocalDatabase>.value(`localDatabase`)))
		let perform = methodPerformValue(.m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`), Parameter<LocalDatabase>.value(`localDatabase`))) as? (String, String, CloudDatabase, LocalDatabase) -> Void
		perform?(`email`, `password`, `cloudDatabase`, `localDatabase`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(Parameter<String>.value(`email`), Parameter<String>.value(`password`), Parameter<CloudDatabase>.value(`cloudDatabase`), Parameter<LocalDatabase>.value(`localDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
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

    open func logout() -> AuthenticationError? {
        addInvocation(.m_logout)
		let perform = methodPerformValue(.m_logout) as? () -> Void
		perform?()
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_logout).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func isUserLoggedIn() -> Bool {
        addInvocation(.m_isUserLoggedIn)
		let perform = methodPerformValue(.m_isUserLoggedIn) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_isUserLoggedIn).casted()
		} catch {
			onFatalFailure("Stub return value not specified for isUserLoggedIn(). Use given")
			Failure("Stub return value not specified for isUserLoggedIn(). Use given")
		}
		return __value
    }

    open func getUserId() -> String? {
        addInvocation(.m_getUserId)
		let perform = methodPerformValue(.m_getUserId) as? () -> Void
		perform?()
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_getUserId).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func updateUserEmailAddress(to newEmail: String, cloudDatabase: CloudDatabase) -> AuthenticationError? {
        addInvocation(.m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(Parameter<String>.value(`newEmail`), Parameter<CloudDatabase>.value(`cloudDatabase`)))
		let perform = methodPerformValue(.m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(Parameter<String>.value(`newEmail`), Parameter<CloudDatabase>.value(`cloudDatabase`))) as? (String, CloudDatabase) -> Void
		perform?(`newEmail`, `cloudDatabase`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(Parameter<String>.value(`newEmail`), Parameter<CloudDatabase>.value(`cloudDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func updateUserPassword(to newPassword: String) -> AuthenticationError? {
        addInvocation(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`)))
		let perform = methodPerformValue(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`))) as? (String) -> Void
		perform?(`newPassword`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_updateUserPassword__to_newPassword(Parameter<String>.value(`newPassword`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func reauthenticateUser(email: String, password: String) -> AuthenticationError? {
        addInvocation(.m_reauthenticateUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`)))
		let perform = methodPerformValue(.m_reauthenticateUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))) as? (String, String) -> Void
		perform?(`email`, `password`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_reauthenticateUser__email_emailpassword_password(Parameter<String>.value(`email`), Parameter<String>.value(`password`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func deleteUser(cloudDatabase: CloudDatabase) -> AuthenticationError? {
        addInvocation(.m_deleteUser__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>.value(`cloudDatabase`)))
		let perform = methodPerformValue(.m_deleteUser__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>.value(`cloudDatabase`))) as? (CloudDatabase) -> Void
		perform?(`cloudDatabase`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_deleteUser__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>.value(`cloudDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func sendPasswordResetEmail(userEmail: String) -> AuthenticationError? {
        addInvocation(.m_sendPasswordResetEmail__userEmail_userEmail(Parameter<String>.value(`userEmail`)))
		let perform = methodPerformValue(.m_sendPasswordResetEmail__userEmail_userEmail(Parameter<String>.value(`userEmail`))) as? (String) -> Void
		perform?(`userEmail`)
		var __value: AuthenticationError? = nil
		do {
		    __value = try methodReturnValue(.m_sendPasswordResetEmail__userEmail_userEmail(Parameter<String>.value(`userEmail`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(Parameter<String>, Parameter<String>, Parameter<CloudDatabase>, Parameter<LocalDatabase>)
        case m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(Parameter<String>, Parameter<String>, Parameter<CloudDatabase>)
        case m_logout
        case m_isUserLoggedIn
        case m_getUserId
        case m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(Parameter<String>, Parameter<CloudDatabase>)
        case m_updateUserPassword__to_newPassword(Parameter<String>)
        case m_reauthenticateUser__email_emailpassword_password(Parameter<String>, Parameter<String>)
        case m_deleteUser__cloudDatabase_cloudDatabase(Parameter<CloudDatabase>)
        case m_sendPasswordResetEmail__userEmail_userEmail(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(let lhsEmail, let lhsPassword, let lhsClouddatabase, let lhsLocaldatabase), .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(let rhsEmail, let rhsPassword, let rhsClouddatabase, let rhsLocaldatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocaldatabase, rhs: rhsLocaldatabase, with: matcher), lhsLocaldatabase, rhsLocaldatabase, "localDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(let lhsEmail, let lhsPassword, let lhsClouddatabase), .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(let rhsEmail, let rhsPassword, let rhsClouddatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_logout, .m_logout): return .match

            case (.m_isUserLoggedIn, .m_isUserLoggedIn): return .match

            case (.m_getUserId, .m_getUserId): return .match

            case (.m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(let lhsNewemail, let lhsClouddatabase), .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(let rhsNewemail, let rhsClouddatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewemail, rhs: rhsNewemail, with: matcher), lhsNewemail, rhsNewemail, "to newEmail"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_updateUserPassword__to_newPassword(let lhsNewpassword), .m_updateUserPassword__to_newPassword(let rhsNewpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewpassword, rhs: rhsNewpassword, with: matcher), lhsNewpassword, rhsNewpassword, "to newPassword"))
				return Matcher.ComparisonResult(results)

            case (.m_reauthenticateUser__email_emailpassword_password(let lhsEmail, let lhsPassword), .m_reauthenticateUser__email_emailpassword_password(let rhsEmail, let rhsPassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEmail, rhs: rhsEmail, with: matcher), lhsEmail, rhsEmail, "email"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPassword, rhs: rhsPassword, with: matcher), lhsPassword, rhsPassword, "password"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteUser__cloudDatabase_cloudDatabase(let lhsClouddatabase), .m_deleteUser__cloudDatabase_cloudDatabase(let rhsClouddatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClouddatabase, rhs: rhsClouddatabase, with: matcher), lhsClouddatabase, rhsClouddatabase, "cloudDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_sendPasswordResetEmail__userEmail_userEmail(let lhsUseremail), .m_sendPasswordResetEmail__userEmail_userEmail(let rhsUseremail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case .m_logout: return 0
            case .m_isUserLoggedIn: return 0
            case .m_getUserId: return 0
            case let .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(p0, p1): return p0.intValue + p1.intValue
            case let .m_updateUserPassword__to_newPassword(p0): return p0.intValue
            case let .m_reauthenticateUser__email_emailpassword_password(p0, p1): return p0.intValue + p1.intValue
            case let .m_deleteUser__cloudDatabase_cloudDatabase(p0): return p0.intValue
            case let .m_sendPasswordResetEmail__userEmail_userEmail(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase: return ".login(email:password:cloudDatabase:localDatabase:)"
            case .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase: return ".createUser(email:password:cloudDatabase:)"
            case .m_logout: return ".logout()"
            case .m_isUserLoggedIn: return ".isUserLoggedIn()"
            case .m_getUserId: return ".getUserId()"
            case .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase: return ".updateUserEmailAddress(to:cloudDatabase:)"
            case .m_updateUserPassword__to_newPassword: return ".updateUserPassword(to:)"
            case .m_reauthenticateUser__email_emailpassword_password: return ".reauthenticateUser(email:password:)"
            case .m_deleteUser__cloudDatabase_cloudDatabase: return ".deleteUser(cloudDatabase:)"
            case .m_sendPasswordResetEmail__userEmail_userEmail: return ".sendPasswordResetEmail(userEmail:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func login(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, localDatabase: Parameter<LocalDatabase>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(`email`, `password`, `cloudDatabase`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func logout(willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_logout, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isUserLoggedIn(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_isUserLoggedIn, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getUserId(willReturn: String?...) -> MethodStub {
            return Given(method: .m_getUserId, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(`newEmail`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_updateUserPassword__to_newPassword(`newPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func reauthenticateUser(email: Parameter<String>, password: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_reauthenticateUser__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func deleteUser(cloudDatabase: Parameter<CloudDatabase>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_deleteUser__cloudDatabase_cloudDatabase(`cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendPasswordResetEmail(userEmail: Parameter<String>, willReturn: AuthenticationError?...) -> MethodStub {
            return Given(method: .m_sendPasswordResetEmail__userEmail_userEmail(`userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func login(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, localDatabase: Parameter<LocalDatabase>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(`email`, `password`, `cloudDatabase`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func logout(willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_logout, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func isUserLoggedIn(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_isUserLoggedIn, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func getUserId(willProduce: (Stubber<String?>) -> Void) -> MethodStub {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .m_getUserId, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(`newEmail`, `cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_updateUserPassword__to_newPassword(`newPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func reauthenticateUser(email: Parameter<String>, password: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_reauthenticateUser__email_emailpassword_password(`email`, `password`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func deleteUser(cloudDatabase: Parameter<CloudDatabase>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_deleteUser__cloudDatabase_cloudDatabase(`cloudDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
        public static func sendPasswordResetEmail(userEmail: Parameter<String>, willProduce: (Stubber<AuthenticationError?>) -> Void) -> MethodStub {
            let willReturn: [AuthenticationError?] = []
			let given: Given = { return Given(method: .m_sendPasswordResetEmail__userEmail_userEmail(`userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AuthenticationError?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func login(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, localDatabase: Parameter<LocalDatabase>) -> Verify { return Verify(method: .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(`email`, `password`, `cloudDatabase`, `localDatabase`))}
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>) -> Verify { return Verify(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`))}
        public static func logout() -> Verify { return Verify(method: .m_logout)}
        public static func isUserLoggedIn() -> Verify { return Verify(method: .m_isUserLoggedIn)}
        public static func getUserId() -> Verify { return Verify(method: .m_getUserId)}
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>) -> Verify { return Verify(method: .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(`newEmail`, `cloudDatabase`))}
        public static func updateUserPassword(to newPassword: Parameter<String>) -> Verify { return Verify(method: .m_updateUserPassword__to_newPassword(`newPassword`))}
        public static func reauthenticateUser(email: Parameter<String>, password: Parameter<String>) -> Verify { return Verify(method: .m_reauthenticateUser__email_emailpassword_password(`email`, `password`))}
        public static func deleteUser(cloudDatabase: Parameter<CloudDatabase>) -> Verify { return Verify(method: .m_deleteUser__cloudDatabase_cloudDatabase(`cloudDatabase`))}
        public static func sendPasswordResetEmail(userEmail: Parameter<String>) -> Verify { return Verify(method: .m_sendPasswordResetEmail__userEmail_userEmail(`userEmail`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func login(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, localDatabase: Parameter<LocalDatabase>, perform: @escaping (String, String, CloudDatabase, LocalDatabase) -> Void) -> Perform {
            return Perform(method: .m_login__email_emailpassword_passwordcloudDatabase_cloudDatabaselocalDatabase_localDatabase(`email`, `password`, `cloudDatabase`, `localDatabase`), performs: perform)
        }
        public static func createUser(email: Parameter<String>, password: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, perform: @escaping (String, String, CloudDatabase) -> Void) -> Perform {
            return Perform(method: .m_createUser__email_emailpassword_passwordcloudDatabase_cloudDatabase(`email`, `password`, `cloudDatabase`), performs: perform)
        }
        public static func logout(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_logout, performs: perform)
        }
        public static func isUserLoggedIn(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_isUserLoggedIn, performs: perform)
        }
        public static func getUserId(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getUserId, performs: perform)
        }
        public static func updateUserEmailAddress(to newEmail: Parameter<String>, cloudDatabase: Parameter<CloudDatabase>, perform: @escaping (String, CloudDatabase) -> Void) -> Perform {
            return Perform(method: .m_updateUserEmailAddress__to_newEmailcloudDatabase_cloudDatabase(`newEmail`, `cloudDatabase`), performs: perform)
        }
        public static func updateUserPassword(to newPassword: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_updateUserPassword__to_newPassword(`newPassword`), performs: perform)
        }
        public static func reauthenticateUser(email: Parameter<String>, password: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_reauthenticateUser__email_emailpassword_password(`email`, `password`), performs: perform)
        }
        public static func deleteUser(cloudDatabase: Parameter<CloudDatabase>, perform: @escaping (CloudDatabase) -> Void) -> Perform {
            return Perform(method: .m_deleteUser__cloudDatabase_cloudDatabase(`cloudDatabase`), performs: perform)
        }
        public static func sendPasswordResetEmail(userEmail: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_sendPasswordResetEmail__userEmail_userEmail(`userEmail`), performs: perform)
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

    open func getSinglePlatformCollection(userId: String, platform: Platform) -> Result<Platform, DatabaseError> {
        addInvocation(.m_getSinglePlatformCollection__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_getSinglePlatformCollection__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))) as? (String, Platform) -> Void
		perform?(`userId`, `platform`)
		var __value: Result<Platform, DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getSinglePlatformCollection__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getSinglePlatformCollection(userId: String, platform: Platform). Use given")
			Failure("Stub return value not specified for getSinglePlatformCollection(userId: String, platform: Platform). Use given")
		}
		return __value
    }

    open func getUserCollection(userId: String) -> Result<[Platform], DatabaseError> {
        addInvocation(.m_getUserCollection__userId_userId(Parameter<String>.value(`userId`)))
		let perform = methodPerformValue(.m_getUserCollection__userId_userId(Parameter<String>.value(`userId`))) as? (String) -> Void
		perform?(`userId`)
		var __value: Result<[Platform], DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getUserCollection__userId_userId(Parameter<String>.value(`userId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getUserCollection(userId: String). Use given")
			Failure("Stub return value not specified for getUserCollection(userId: String). Use given")
		}
		return __value
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

    open func saveUser(userId: String, userEmail: String) -> DatabaseError? {
        addInvocation(.m_saveUser__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`)))
		let perform = methodPerformValue(.m_saveUser__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`))) as? (String, String) -> Void
		perform?(`userId`, `userEmail`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveUser__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveUserEmail(userId: String, userEmail: String) -> DatabaseError? {
        addInvocation(.m_saveUserEmail__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`)))
		let perform = methodPerformValue(.m_saveUserEmail__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`))) as? (String, String) -> Void
		perform?(`userId`, `userEmail`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveUserEmail__userId_userIduserEmail_userEmail(Parameter<String>.value(`userId`), Parameter<String>.value(`userEmail`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveGames(userId: String, platform: Platform) -> DatabaseError? {
        addInvocation(.m_saveGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_saveGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))) as? (String, Platform) -> Void
		perform?(`userId`, `platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveGame(userId: String, game: SavedGame, platform: Platform, editingEntry: Bool) -> DatabaseError? {
        addInvocation(.m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`game`), Parameter<Platform>.value(`platform`), Parameter<Bool>.value(`editingEntry`)))
		let perform = methodPerformValue(.m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`game`), Parameter<Platform>.value(`platform`), Parameter<Bool>.value(`editingEntry`))) as? (String, SavedGame, Platform, Bool) -> Void
		perform?(`userId`, `game`, `platform`, `editingEntry`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`game`), Parameter<Platform>.value(`platform`), Parameter<Bool>.value(`editingEntry`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func savePlatform(userId: String, platform: Platform) -> DatabaseError? {
        addInvocation(.m_savePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_savePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))) as? (String, Platform) -> Void
		perform?(`userId`, `platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_savePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveCollection(userId: String, localDatabase: LocalDatabase) -> DatabaseError? {
        addInvocation(.m_saveCollection__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`)))
		let perform = methodPerformValue(.m_saveCollection__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`))) as? (String, LocalDatabase) -> Void
		perform?(`userId`, `localDatabase`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_saveCollection__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func gameIsInDatabase(userId: String, savedGame: SavedGame) -> Result<Bool, DatabaseError> {
        addInvocation(.m_gameIsInDatabase__userId_userIdsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`savedGame`)))
		let perform = methodPerformValue(.m_gameIsInDatabase__userId_userIdsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`savedGame`))) as? (String, SavedGame) -> Void
		perform?(`userId`, `savedGame`)
		var __value: Result<Bool, DatabaseError>
		do {
		    __value = try methodReturnValue(.m_gameIsInDatabase__userId_userIdsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<SavedGame>.value(`savedGame`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for gameIsInDatabase(userId: String, savedGame: SavedGame). Use given")
			Failure("Stub return value not specified for gameIsInDatabase(userId: String, savedGame: SavedGame). Use given")
		}
		return __value
    }

    open func removeGame(userId: String, platform: Platform, savedGame: SavedGame) -> DatabaseError? {
        addInvocation(.m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`), Parameter<SavedGame>.value(`savedGame`)))
		let perform = methodPerformValue(.m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`), Parameter<SavedGame>.value(`savedGame`))) as? (String, Platform, SavedGame) -> Void
		perform?(`userId`, `platform`, `savedGame`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`), Parameter<SavedGame>.value(`savedGame`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func removeUser(userId: String) -> DatabaseError? {
        addInvocation(.m_removeUser__userId_userId(Parameter<String>.value(`userId`)))
		let perform = methodPerformValue(.m_removeUser__userId_userId(Parameter<String>.value(`userId`))) as? (String) -> Void
		perform?(`userId`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_removeUser__userId_userId(Parameter<String>.value(`userId`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func removePlatform(userId: String, platform: Platform) -> DatabaseError? {
        addInvocation(.m_removePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_removePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))) as? (String, Platform) -> Void
		perform?(`userId`, `platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_removePlatform__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func removePlatformAndGames(userId: String, platform: Platform) -> DatabaseError? {
        addInvocation(.m_removePlatformAndGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_removePlatformAndGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))) as? (String, Platform) -> Void
		perform?(`userId`, `platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_removePlatformAndGames__userId_userIdplatform_platform(Parameter<String>.value(`userId`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) -> DatabaseError? {
        addInvocation(.m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`)))
		let perform = methodPerformValue(.m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`))) as? (String, LocalDatabase) -> Void
		perform?(`userId`, `localDatabase`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(Parameter<String>.value(`userId`), Parameter<LocalDatabase>.value(`localDatabase`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getApiKey
        case m_getSinglePlatformCollection__userId_userIdplatform_platform(Parameter<String>, Parameter<Platform>)
        case m_getUserCollection__userId_userId(Parameter<String>)
        case m_getAvailablePlatforms
        case m_saveUser__userId_userIduserEmail_userEmail(Parameter<String>, Parameter<String>)
        case m_saveUserEmail__userId_userIduserEmail_userEmail(Parameter<String>, Parameter<String>)
        case m_saveGames__userId_userIdplatform_platform(Parameter<String>, Parameter<Platform>)
        case m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(Parameter<String>, Parameter<SavedGame>, Parameter<Platform>, Parameter<Bool>)
        case m_savePlatform__userId_userIdplatform_platform(Parameter<String>, Parameter<Platform>)
        case m_saveCollection__userId_userIdlocalDatabase_localDatabase(Parameter<String>, Parameter<LocalDatabase>)
        case m_gameIsInDatabase__userId_userIdsavedGame_savedGame(Parameter<String>, Parameter<SavedGame>)
        case m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(Parameter<String>, Parameter<Platform>, Parameter<SavedGame>)
        case m_removeUser__userId_userId(Parameter<String>)
        case m_removePlatform__userId_userIdplatform_platform(Parameter<String>, Parameter<Platform>)
        case m_removePlatformAndGames__userId_userIdplatform_platform(Parameter<String>, Parameter<Platform>)
        case m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(Parameter<String>, Parameter<LocalDatabase>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getApiKey, .m_getApiKey): return .match

            case (.m_getSinglePlatformCollection__userId_userIdplatform_platform(let lhsUserid, let lhsPlatform), .m_getSinglePlatformCollection__userId_userIdplatform_platform(let rhsUserid, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_getUserCollection__userId_userId(let lhsUserid), .m_getUserCollection__userId_userId(let rhsUserid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				return Matcher.ComparisonResult(results)

            case (.m_getAvailablePlatforms, .m_getAvailablePlatforms): return .match

            case (.m_saveUser__userId_userIduserEmail_userEmail(let lhsUserid, let lhsUseremail), .m_saveUser__userId_userIduserEmail_userEmail(let rhsUserid, let rhsUseremail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				return Matcher.ComparisonResult(results)

            case (.m_saveUserEmail__userId_userIduserEmail_userEmail(let lhsUserid, let lhsUseremail), .m_saveUserEmail__userId_userIduserEmail_userEmail(let rhsUserid, let rhsUseremail)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUseremail, rhs: rhsUseremail, with: matcher), lhsUseremail, rhsUseremail, "userEmail"))
				return Matcher.ComparisonResult(results)

            case (.m_saveGames__userId_userIdplatform_platform(let lhsUserid, let lhsPlatform), .m_saveGames__userId_userIdplatform_platform(let rhsUserid, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(let lhsUserid, let lhsGame, let lhsPlatform, let lhsEditingentry), .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(let rhsUserid, let rhsGame, let rhsPlatform, let rhsEditingentry)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsGame, rhs: rhsGame, with: matcher), lhsGame, rhsGame, "game"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEditingentry, rhs: rhsEditingentry, with: matcher), lhsEditingentry, rhsEditingentry, "editingEntry"))
				return Matcher.ComparisonResult(results)

            case (.m_savePlatform__userId_userIdplatform_platform(let lhsUserid, let lhsPlatform), .m_savePlatform__userId_userIdplatform_platform(let rhsUserid, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_saveCollection__userId_userIdlocalDatabase_localDatabase(let lhsUserid, let lhsLocaldatabase), .m_saveCollection__userId_userIdlocalDatabase_localDatabase(let rhsUserid, let rhsLocaldatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocaldatabase, rhs: rhsLocaldatabase, with: matcher), lhsLocaldatabase, rhsLocaldatabase, "localDatabase"))
				return Matcher.ComparisonResult(results)

            case (.m_gameIsInDatabase__userId_userIdsavedGame_savedGame(let lhsUserid, let lhsSavedgame), .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(let rhsUserid, let rhsSavedgame)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				return Matcher.ComparisonResult(results)

            case (.m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(let lhsUserid, let lhsPlatform, let lhsSavedgame), .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(let rhsUserid, let rhsPlatform, let rhsSavedgame)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				return Matcher.ComparisonResult(results)

            case (.m_removeUser__userId_userId(let lhsUserid), .m_removeUser__userId_userId(let rhsUserid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				return Matcher.ComparisonResult(results)

            case (.m_removePlatform__userId_userIdplatform_platform(let lhsUserid, let lhsPlatform), .m_removePlatform__userId_userIdplatform_platform(let rhsUserid, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_removePlatformAndGames__userId_userIdplatform_platform(let lhsUserid, let lhsPlatform), .m_removePlatformAndGames__userId_userIdplatform_platform(let rhsUserid, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(let lhsUserid, let lhsLocaldatabase), .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(let rhsUserid, let rhsLocaldatabase)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocaldatabase, rhs: rhsLocaldatabase, with: matcher), lhsLocaldatabase, rhsLocaldatabase, "localDatabase"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getApiKey: return 0
            case let .m_getSinglePlatformCollection__userId_userIdplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_getUserCollection__userId_userId(p0): return p0.intValue
            case .m_getAvailablePlatforms: return 0
            case let .m_saveUser__userId_userIduserEmail_userEmail(p0, p1): return p0.intValue + p1.intValue
            case let .m_saveUserEmail__userId_userIduserEmail_userEmail(p0, p1): return p0.intValue + p1.intValue
            case let .m_saveGames__userId_userIdplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_savePlatform__userId_userIdplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_saveCollection__userId_userIdlocalDatabase_localDatabase(p0, p1): return p0.intValue + p1.intValue
            case let .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(p0, p1): return p0.intValue + p1.intValue
            case let .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_removeUser__userId_userId(p0): return p0.intValue
            case let .m_removePlatform__userId_userIdplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_removePlatformAndGames__userId_userIdplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getApiKey: return ".getApiKey()"
            case .m_getSinglePlatformCollection__userId_userIdplatform_platform: return ".getSinglePlatformCollection(userId:platform:)"
            case .m_getUserCollection__userId_userId: return ".getUserCollection(userId:)"
            case .m_getAvailablePlatforms: return ".getAvailablePlatforms()"
            case .m_saveUser__userId_userIduserEmail_userEmail: return ".saveUser(userId:userEmail:)"
            case .m_saveUserEmail__userId_userIduserEmail_userEmail: return ".saveUserEmail(userId:userEmail:)"
            case .m_saveGames__userId_userIdplatform_platform: return ".saveGames(userId:platform:)"
            case .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry: return ".saveGame(userId:game:platform:editingEntry:)"
            case .m_savePlatform__userId_userIdplatform_platform: return ".savePlatform(userId:platform:)"
            case .m_saveCollection__userId_userIdlocalDatabase_localDatabase: return ".saveCollection(userId:localDatabase:)"
            case .m_gameIsInDatabase__userId_userIdsavedGame_savedGame: return ".gameIsInDatabase(userId:savedGame:)"
            case .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame: return ".removeGame(userId:platform:savedGame:)"
            case .m_removeUser__userId_userId: return ".removeUser(userId:)"
            case .m_removePlatform__userId_userIdplatform_platform: return ".removePlatform(userId:platform:)"
            case .m_removePlatformAndGames__userId_userIdplatform_platform: return ".removePlatformAndGames(userId:platform:)"
            case .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase: return ".syncLocalAndCloudDatabases(userId:localDatabase:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getApiKey(willReturn: Result<String, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getApiKey, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getSinglePlatformCollection(userId: Parameter<String>, platform: Parameter<Platform>, willReturn: Result<Platform, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getSinglePlatformCollection__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getUserCollection(userId: Parameter<String>, willReturn: Result<[Platform], DatabaseError>...) -> MethodStub {
            return Given(method: .m_getUserCollection__userId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getAvailablePlatforms(willReturn: Result<[Platform], DatabaseError>...) -> MethodStub {
            return Given(method: .m_getAvailablePlatforms, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveUser(userId: Parameter<String>, userEmail: Parameter<String>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveUser__userId_userIduserEmail_userEmail(`userId`, `userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveUserEmail(userId: Parameter<String>, userEmail: Parameter<String>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveUserEmail__userId_userIduserEmail_userEmail(`userId`, `userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveGames(userId: Parameter<String>, platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveGames__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveGame(userId: Parameter<String>, game: Parameter<SavedGame>, platform: Parameter<Platform>, editingEntry: Parameter<Bool>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(`userId`, `game`, `platform`, `editingEntry`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func savePlatform(userId: Parameter<String>, platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_savePlatform__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveCollection(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_saveCollection__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func gameIsInDatabase(userId: Parameter<String>, savedGame: Parameter<SavedGame>, willReturn: Result<Bool, DatabaseError>...) -> MethodStub {
            return Given(method: .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(`userId`, `savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removeGame(userId: Parameter<String>, platform: Parameter<Platform>, savedGame: Parameter<SavedGame>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(`userId`, `platform`, `savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removeUser(userId: Parameter<String>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_removeUser__userId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removePlatform(userId: Parameter<String>, platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_removePlatform__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removePlatformAndGames(userId: Parameter<String>, platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_removePlatformAndGames__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func syncLocalAndCloudDatabases(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getApiKey(willProduce: (Stubber<Result<String, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<String, DatabaseError>] = []
			let given: Given = { return Given(method: .m_getApiKey, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<String, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func getSinglePlatformCollection(userId: Parameter<String>, platform: Parameter<Platform>, willProduce: (Stubber<Result<Platform, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<Platform, DatabaseError>] = []
			let given: Given = { return Given(method: .m_getSinglePlatformCollection__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<Platform, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func getUserCollection(userId: Parameter<String>, willProduce: (Stubber<Result<[Platform], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[Platform], DatabaseError>] = []
			let given: Given = { return Given(method: .m_getUserCollection__userId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[Platform], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func getAvailablePlatforms(willProduce: (Stubber<Result<[Platform], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[Platform], DatabaseError>] = []
			let given: Given = { return Given(method: .m_getAvailablePlatforms, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[Platform], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func saveUser(userId: Parameter<String>, userEmail: Parameter<String>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveUser__userId_userIduserEmail_userEmail(`userId`, `userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveUserEmail(userId: Parameter<String>, userEmail: Parameter<String>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveUserEmail__userId_userIduserEmail_userEmail(`userId`, `userEmail`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveGames(userId: Parameter<String>, platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveGames__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveGame(userId: Parameter<String>, game: Parameter<SavedGame>, platform: Parameter<Platform>, editingEntry: Parameter<Bool>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(`userId`, `game`, `platform`, `editingEntry`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func savePlatform(userId: Parameter<String>, platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_savePlatform__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func saveCollection(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_saveCollection__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func gameIsInDatabase(userId: Parameter<String>, savedGame: Parameter<SavedGame>, willProduce: (Stubber<Result<Bool, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<Bool, DatabaseError>] = []
			let given: Given = { return Given(method: .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(`userId`, `savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<Bool, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func removeGame(userId: Parameter<String>, platform: Parameter<Platform>, savedGame: Parameter<SavedGame>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(`userId`, `platform`, `savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func removeUser(userId: Parameter<String>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_removeUser__userId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func removePlatform(userId: Parameter<String>, platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_removePlatform__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func removePlatformAndGames(userId: Parameter<String>, platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_removePlatformAndGames__userId_userIdplatform_platform(`userId`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func syncLocalAndCloudDatabases(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getApiKey() -> Verify { return Verify(method: .m_getApiKey)}
        public static func getSinglePlatformCollection(userId: Parameter<String>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_getSinglePlatformCollection__userId_userIdplatform_platform(`userId`, `platform`))}
        public static func getUserCollection(userId: Parameter<String>) -> Verify { return Verify(method: .m_getUserCollection__userId_userId(`userId`))}
        public static func getAvailablePlatforms() -> Verify { return Verify(method: .m_getAvailablePlatforms)}
        public static func saveUser(userId: Parameter<String>, userEmail: Parameter<String>) -> Verify { return Verify(method: .m_saveUser__userId_userIduserEmail_userEmail(`userId`, `userEmail`))}
        public static func saveUserEmail(userId: Parameter<String>, userEmail: Parameter<String>) -> Verify { return Verify(method: .m_saveUserEmail__userId_userIduserEmail_userEmail(`userId`, `userEmail`))}
        public static func saveGames(userId: Parameter<String>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_saveGames__userId_userIdplatform_platform(`userId`, `platform`))}
        public static func saveGame(userId: Parameter<String>, game: Parameter<SavedGame>, platform: Parameter<Platform>, editingEntry: Parameter<Bool>) -> Verify { return Verify(method: .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(`userId`, `game`, `platform`, `editingEntry`))}
        public static func savePlatform(userId: Parameter<String>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_savePlatform__userId_userIdplatform_platform(`userId`, `platform`))}
        public static func saveCollection(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>) -> Verify { return Verify(method: .m_saveCollection__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`))}
        public static func gameIsInDatabase(userId: Parameter<String>, savedGame: Parameter<SavedGame>) -> Verify { return Verify(method: .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(`userId`, `savedGame`))}
        public static func removeGame(userId: Parameter<String>, platform: Parameter<Platform>, savedGame: Parameter<SavedGame>) -> Verify { return Verify(method: .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(`userId`, `platform`, `savedGame`))}
        public static func removeUser(userId: Parameter<String>) -> Verify { return Verify(method: .m_removeUser__userId_userId(`userId`))}
        public static func removePlatform(userId: Parameter<String>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_removePlatform__userId_userIdplatform_platform(`userId`, `platform`))}
        public static func removePlatformAndGames(userId: Parameter<String>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_removePlatformAndGames__userId_userIdplatform_platform(`userId`, `platform`))}
        public static func syncLocalAndCloudDatabases(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>) -> Verify { return Verify(method: .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getApiKey(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getApiKey, performs: perform)
        }
        public static func getSinglePlatformCollection(userId: Parameter<String>, platform: Parameter<Platform>, perform: @escaping (String, Platform) -> Void) -> Perform {
            return Perform(method: .m_getSinglePlatformCollection__userId_userIdplatform_platform(`userId`, `platform`), performs: perform)
        }
        public static func getUserCollection(userId: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getUserCollection__userId_userId(`userId`), performs: perform)
        }
        public static func getAvailablePlatforms(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAvailablePlatforms, performs: perform)
        }
        public static func saveUser(userId: Parameter<String>, userEmail: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_saveUser__userId_userIduserEmail_userEmail(`userId`, `userEmail`), performs: perform)
        }
        public static func saveUserEmail(userId: Parameter<String>, userEmail: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_saveUserEmail__userId_userIduserEmail_userEmail(`userId`, `userEmail`), performs: perform)
        }
        public static func saveGames(userId: Parameter<String>, platform: Parameter<Platform>, perform: @escaping (String, Platform) -> Void) -> Perform {
            return Perform(method: .m_saveGames__userId_userIdplatform_platform(`userId`, `platform`), performs: perform)
        }
        public static func saveGame(userId: Parameter<String>, game: Parameter<SavedGame>, platform: Parameter<Platform>, editingEntry: Parameter<Bool>, perform: @escaping (String, SavedGame, Platform, Bool) -> Void) -> Perform {
            return Perform(method: .m_saveGame__userId_userIdgame_gameplatform_platformeditingEntry_editingEntry(`userId`, `game`, `platform`, `editingEntry`), performs: perform)
        }
        public static func savePlatform(userId: Parameter<String>, platform: Parameter<Platform>, perform: @escaping (String, Platform) -> Void) -> Perform {
            return Perform(method: .m_savePlatform__userId_userIdplatform_platform(`userId`, `platform`), performs: perform)
        }
        public static func saveCollection(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, perform: @escaping (String, LocalDatabase) -> Void) -> Perform {
            return Perform(method: .m_saveCollection__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), performs: perform)
        }
        public static func gameIsInDatabase(userId: Parameter<String>, savedGame: Parameter<SavedGame>, perform: @escaping (String, SavedGame) -> Void) -> Perform {
            return Perform(method: .m_gameIsInDatabase__userId_userIdsavedGame_savedGame(`userId`, `savedGame`), performs: perform)
        }
        public static func removeGame(userId: Parameter<String>, platform: Parameter<Platform>, savedGame: Parameter<SavedGame>, perform: @escaping (String, Platform, SavedGame) -> Void) -> Perform {
            return Perform(method: .m_removeGame__userId_userIdplatform_platformsavedGame_savedGame(`userId`, `platform`, `savedGame`), performs: perform)
        }
        public static func removeUser(userId: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_removeUser__userId_userId(`userId`), performs: perform)
        }
        public static func removePlatform(userId: Parameter<String>, platform: Parameter<Platform>, perform: @escaping (String, Platform) -> Void) -> Perform {
            return Perform(method: .m_removePlatform__userId_userIdplatform_platform(`userId`, `platform`), performs: perform)
        }
        public static func removePlatformAndGames(userId: Parameter<String>, platform: Parameter<Platform>, perform: @escaping (String, Platform) -> Void) -> Perform {
            return Perform(method: .m_removePlatformAndGames__userId_userIdplatform_platform(`userId`, `platform`), performs: perform)
        }
        public static func syncLocalAndCloudDatabases(userId: Parameter<String>, localDatabase: Parameter<LocalDatabase>, perform: @escaping (String, LocalDatabase) -> Void) -> Perform {
            return Perform(method: .m_syncLocalAndCloudDatabases__userId_userIdlocalDatabase_localDatabase(`userId`, `localDatabase`), performs: perform)
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

// MARK: - ConnectivityChecker

open class ConnectivityCheckerMock: ConnectivityChecker, Mock {
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





    open func hasConnectivity() -> Bool {
        addInvocation(.m_hasConnectivity)
		let perform = methodPerformValue(.m_hasConnectivity) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_hasConnectivity).casted()
		} catch {
			onFatalFailure("Stub return value not specified for hasConnectivity(). Use given")
			Failure("Stub return value not specified for hasConnectivity(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_hasConnectivity

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_hasConnectivity, .m_hasConnectivity): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_hasConnectivity: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_hasConnectivity: return ".hasConnectivity()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func hasConnectivity(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_hasConnectivity, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func hasConnectivity(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_hasConnectivity, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func hasConnectivity() -> Verify { return Verify(method: .m_hasConnectivity)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func hasConnectivity(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_hasConnectivity, performs: perform)
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





    open func configureSupplementaryView(contentViewFactory: ContentViewFactory) {
        addInvocation(.m_configureSupplementaryView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>.value(`contentViewFactory`)))
		let perform = methodPerformValue(.m_configureSupplementaryView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>.value(`contentViewFactory`))) as? (ContentViewFactory) -> Void
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

    open func reloadNavBar() {
        addInvocation(.m_reloadNavBar)
		let perform = methodPerformValue(.m_reloadNavBar) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_configureSupplementaryView__contentViewFactory_contentViewFactory(Parameter<ContentViewFactory>)
        case m_reloadSections
        case m_goBackToRootViewController
        case m_reloadNavBar

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_configureSupplementaryView__contentViewFactory_contentViewFactory(let lhsContentviewfactory), .m_configureSupplementaryView__contentViewFactory_contentViewFactory(let rhsContentviewfactory)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsContentviewfactory, rhs: rhsContentviewfactory, with: matcher), lhsContentviewfactory, rhsContentviewfactory, "contentViewFactory"))
				return Matcher.ComparisonResult(results)

            case (.m_reloadSections, .m_reloadSections): return .match

            case (.m_goBackToRootViewController, .m_goBackToRootViewController): return .match

            case (.m_reloadNavBar, .m_reloadNavBar): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_configureSupplementaryView__contentViewFactory_contentViewFactory(p0): return p0.intValue
            case .m_reloadSections: return 0
            case .m_goBackToRootViewController: return 0
            case .m_reloadNavBar: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_configureSupplementaryView__contentViewFactory_contentViewFactory: return ".configureSupplementaryView(contentViewFactory:)"
            case .m_reloadSections: return ".reloadSections()"
            case .m_goBackToRootViewController: return ".goBackToRootViewController()"
            case .m_reloadNavBar: return ".reloadNavBar()"
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

        public static func configureSupplementaryView(contentViewFactory: Parameter<ContentViewFactory>) -> Verify { return Verify(method: .m_configureSupplementaryView__contentViewFactory_contentViewFactory(`contentViewFactory`))}
        public static func reloadSections() -> Verify { return Verify(method: .m_reloadSections)}
        public static func goBackToRootViewController() -> Verify { return Verify(method: .m_goBackToRootViewController)}
        public static func reloadNavBar() -> Verify { return Verify(method: .m_reloadNavBar)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func configureSupplementaryView(contentViewFactory: Parameter<ContentViewFactory>, perform: @escaping (ContentViewFactory) -> Void) -> Perform {
            return Perform(method: .m_configureSupplementaryView__contentViewFactory_contentViewFactory(`contentViewFactory`), performs: perform)
        }
        public static func reloadSections(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reloadSections, performs: perform)
        }
        public static func goBackToRootViewController(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_goBackToRootViewController, performs: perform)
        }
        public static func reloadNavBar(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_reloadNavBar, performs: perform)
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

// MARK: - FirestoreSession

open class FirestoreSessionMock: FirestoreSession, Mock {
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





    open func getData(mainPath: String) -> Result<[FirestoreData], DatabaseError> {
        addInvocation(.m_getData__mainPath_mainPath(Parameter<String>.value(`mainPath`)))
		let perform = methodPerformValue(.m_getData__mainPath_mainPath(Parameter<String>.value(`mainPath`))) as? (String) -> Void
		perform?(`mainPath`)
		var __value: Result<[FirestoreData], DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getData__mainPath_mainPath(Parameter<String>.value(`mainPath`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getData(mainPath: String). Use given")
			Failure("Stub return value not specified for getData(mainPath: String). Use given")
		}
		return __value
    }

    open func getSingleData(path: String, directory: String) -> Result<FirestoreData, DatabaseError> {
        addInvocation(.m_getSingleData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`)))
		let perform = methodPerformValue(.m_getSingleData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`))) as? (String, String) -> Void
		perform?(`path`, `directory`)
		var __value: Result<FirestoreData, DatabaseError>
		do {
		    __value = try methodReturnValue(.m_getSingleData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getSingleData(path: String, directory: String). Use given")
			Failure("Stub return value not specified for getSingleData(path: String, directory: String). Use given")
		}
		return __value
    }

    open func setData(path: String, firestoreData: FirestoreData) -> DatabaseError? {
        addInvocation(.m_setData__path_pathfirestoreData_firestoreData(Parameter<String>.value(`path`), Parameter<FirestoreData>.value(`firestoreData`)))
		let perform = methodPerformValue(.m_setData__path_pathfirestoreData_firestoreData(Parameter<String>.value(`path`), Parameter<FirestoreData>.value(`firestoreData`))) as? (String, FirestoreData) -> Void
		perform?(`path`, `firestoreData`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_setData__path_pathfirestoreData_firestoreData(Parameter<String>.value(`path`), Parameter<FirestoreData>.value(`firestoreData`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func deleteData(path: String, directory: String) -> DatabaseError? {
        addInvocation(.m_deleteData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`)))
		let perform = methodPerformValue(.m_deleteData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`))) as? (String, String) -> Void
		perform?(`path`, `directory`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_deleteData__path_pathdirectory_directory(Parameter<String>.value(`path`), Parameter<String>.value(`directory`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getData__mainPath_mainPath(Parameter<String>)
        case m_getSingleData__path_pathdirectory_directory(Parameter<String>, Parameter<String>)
        case m_setData__path_pathfirestoreData_firestoreData(Parameter<String>, Parameter<FirestoreData>)
        case m_deleteData__path_pathdirectory_directory(Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getData__mainPath_mainPath(let lhsMainpath), .m_getData__mainPath_mainPath(let rhsMainpath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMainpath, rhs: rhsMainpath, with: matcher), lhsMainpath, rhsMainpath, "mainPath"))
				return Matcher.ComparisonResult(results)

            case (.m_getSingleData__path_pathdirectory_directory(let lhsPath, let lhsDirectory), .m_getSingleData__path_pathdirectory_directory(let rhsPath, let rhsDirectory)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDirectory, rhs: rhsDirectory, with: matcher), lhsDirectory, rhsDirectory, "directory"))
				return Matcher.ComparisonResult(results)

            case (.m_setData__path_pathfirestoreData_firestoreData(let lhsPath, let lhsFirestoredata), .m_setData__path_pathfirestoreData_firestoreData(let rhsPath, let rhsFirestoredata)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFirestoredata, rhs: rhsFirestoredata, with: matcher), lhsFirestoredata, rhsFirestoredata, "firestoreData"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteData__path_pathdirectory_directory(let lhsPath, let lhsDirectory), .m_deleteData__path_pathdirectory_directory(let rhsPath, let rhsDirectory)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "path"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDirectory, rhs: rhsDirectory, with: matcher), lhsDirectory, rhsDirectory, "directory"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getData__mainPath_mainPath(p0): return p0.intValue
            case let .m_getSingleData__path_pathdirectory_directory(p0, p1): return p0.intValue + p1.intValue
            case let .m_setData__path_pathfirestoreData_firestoreData(p0, p1): return p0.intValue + p1.intValue
            case let .m_deleteData__path_pathdirectory_directory(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getData__mainPath_mainPath: return ".getData(mainPath:)"
            case .m_getSingleData__path_pathdirectory_directory: return ".getSingleData(path:directory:)"
            case .m_setData__path_pathfirestoreData_firestoreData: return ".setData(path:firestoreData:)"
            case .m_deleteData__path_pathdirectory_directory: return ".deleteData(path:directory:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getData(mainPath: Parameter<String>, willReturn: Result<[FirestoreData], DatabaseError>...) -> MethodStub {
            return Given(method: .m_getData__mainPath_mainPath(`mainPath`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getSingleData(path: Parameter<String>, directory: Parameter<String>, willReturn: Result<FirestoreData, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getSingleData__path_pathdirectory_directory(`path`, `directory`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func setData(path: Parameter<String>, firestoreData: Parameter<FirestoreData>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_setData__path_pathfirestoreData_firestoreData(`path`, `firestoreData`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func deleteData(path: Parameter<String>, directory: Parameter<String>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_deleteData__path_pathdirectory_directory(`path`, `directory`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getData(mainPath: Parameter<String>, willProduce: (Stubber<Result<[FirestoreData], DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<[FirestoreData], DatabaseError>] = []
			let given: Given = { return Given(method: .m_getData__mainPath_mainPath(`mainPath`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<[FirestoreData], DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func getSingleData(path: Parameter<String>, directory: Parameter<String>, willProduce: (Stubber<Result<FirestoreData, DatabaseError>>) -> Void) -> MethodStub {
            let willReturn: [Result<FirestoreData, DatabaseError>] = []
			let given: Given = { return Given(method: .m_getSingleData__path_pathdirectory_directory(`path`, `directory`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Result<FirestoreData, DatabaseError>).self)
			willProduce(stubber)
			return given
        }
        public static func setData(path: Parameter<String>, firestoreData: Parameter<FirestoreData>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_setData__path_pathfirestoreData_firestoreData(`path`, `firestoreData`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func deleteData(path: Parameter<String>, directory: Parameter<String>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_deleteData__path_pathdirectory_directory(`path`, `directory`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getData(mainPath: Parameter<String>) -> Verify { return Verify(method: .m_getData__mainPath_mainPath(`mainPath`))}
        public static func getSingleData(path: Parameter<String>, directory: Parameter<String>) -> Verify { return Verify(method: .m_getSingleData__path_pathdirectory_directory(`path`, `directory`))}
        public static func setData(path: Parameter<String>, firestoreData: Parameter<FirestoreData>) -> Verify { return Verify(method: .m_setData__path_pathfirestoreData_firestoreData(`path`, `firestoreData`))}
        public static func deleteData(path: Parameter<String>, directory: Parameter<String>) -> Verify { return Verify(method: .m_deleteData__path_pathdirectory_directory(`path`, `directory`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getData(mainPath: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getData__mainPath_mainPath(`mainPath`), performs: perform)
        }
        public static func getSingleData(path: Parameter<String>, directory: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_getSingleData__path_pathdirectory_directory(`path`, `directory`), performs: perform)
        }
        public static func setData(path: Parameter<String>, firestoreData: Parameter<FirestoreData>, perform: @escaping (String, FirestoreData) -> Void) -> Perform {
            return Perform(method: .m_setData__path_pathfirestoreData_firestoreData(`path`, `firestoreData`), performs: perform)
        }
        public static func deleteData(path: Parameter<String>, directory: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_deleteData__path_pathdirectory_directory(`path`, `directory`), performs: perform)
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





    open func add(newEntity: SavedGame, platform: Platform) -> DatabaseError? {
        addInvocation(.m_add__newEntity_newEntityplatform_platform(Parameter<SavedGame>.value(`newEntity`), Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_add__newEntity_newEntityplatform_platform(Parameter<SavedGame>.value(`newEntity`), Parameter<Platform>.value(`platform`))) as? (SavedGame, Platform) -> Void
		perform?(`newEntity`, `platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_add__newEntity_newEntityplatform_platform(Parameter<SavedGame>.value(`newEntity`), Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
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

    open func replace(savedGame: SavedGame) -> DatabaseError? {
        addInvocation(.m_replace__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`)))
		let perform = methodPerformValue(.m_replace__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`))) as? (SavedGame) -> Void
		perform?(`savedGame`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_replace__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func remove(savedGame: SavedGame) -> DatabaseError? {
        addInvocation(.m_remove__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`)))
		let perform = methodPerformValue(.m_remove__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`))) as? (SavedGame) -> Void
		perform?(`savedGame`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_remove__savedGame_savedGame(Parameter<SavedGame>.value(`savedGame`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func remove(platform: Platform) -> DatabaseError? {
        addInvocation(.m_remove__platform_platform(Parameter<Platform>.value(`platform`)))
		let perform = methodPerformValue(.m_remove__platform_platform(Parameter<Platform>.value(`platform`))) as? (Platform) -> Void
		perform?(`platform`)
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_remove__platform_platform(Parameter<Platform>.value(`platform`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func removeAll() -> DatabaseError? {
        addInvocation(.m_removeAll)
		let perform = methodPerformValue(.m_removeAll) as? () -> Void
		perform?()
		var __value: DatabaseError? = nil
		do {
		    __value = try methodReturnValue(.m_removeAll).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_add__newEntity_newEntityplatform_platform(Parameter<SavedGame>, Parameter<Platform>)
        case m_getPlatform__platformId_platformId(Parameter<Int>)
        case m_fetchAllPlatforms
        case m_replace__savedGame_savedGame(Parameter<SavedGame>)
        case m_remove__savedGame_savedGame(Parameter<SavedGame>)
        case m_remove__platform_platform(Parameter<Platform>)
        case m_removeAll

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_add__newEntity_newEntityplatform_platform(let lhsNewentity, let lhsPlatform), .m_add__newEntity_newEntityplatform_platform(let rhsNewentity, let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewentity, rhs: rhsNewentity, with: matcher), lhsNewentity, rhsNewentity, "newEntity"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_getPlatform__platformId_platformId(let lhsPlatformid), .m_getPlatform__platformId_platformId(let rhsPlatformid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatformid, rhs: rhsPlatformid, with: matcher), lhsPlatformid, rhsPlatformid, "platformId"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchAllPlatforms, .m_fetchAllPlatforms): return .match

            case (.m_replace__savedGame_savedGame(let lhsSavedgame), .m_replace__savedGame_savedGame(let rhsSavedgame)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				return Matcher.ComparisonResult(results)

            case (.m_remove__savedGame_savedGame(let lhsSavedgame), .m_remove__savedGame_savedGame(let rhsSavedgame)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSavedgame, rhs: rhsSavedgame, with: matcher), lhsSavedgame, rhsSavedgame, "savedGame"))
				return Matcher.ComparisonResult(results)

            case (.m_remove__platform_platform(let lhsPlatform), .m_remove__platform_platform(let rhsPlatform)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPlatform, rhs: rhsPlatform, with: matcher), lhsPlatform, rhsPlatform, "platform"))
				return Matcher.ComparisonResult(results)

            case (.m_removeAll, .m_removeAll): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_add__newEntity_newEntityplatform_platform(p0, p1): return p0.intValue + p1.intValue
            case let .m_getPlatform__platformId_platformId(p0): return p0.intValue
            case .m_fetchAllPlatforms: return 0
            case let .m_replace__savedGame_savedGame(p0): return p0.intValue
            case let .m_remove__savedGame_savedGame(p0): return p0.intValue
            case let .m_remove__platform_platform(p0): return p0.intValue
            case .m_removeAll: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_add__newEntity_newEntityplatform_platform: return ".add(newEntity:platform:)"
            case .m_getPlatform__platformId_platformId: return ".getPlatform(platformId:)"
            case .m_fetchAllPlatforms: return ".fetchAllPlatforms()"
            case .m_replace__savedGame_savedGame: return ".replace(savedGame:)"
            case .m_remove__savedGame_savedGame: return ".remove(savedGame:)"
            case .m_remove__platform_platform: return ".remove(platform:)"
            case .m_removeAll: return ".removeAll()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_add__newEntity_newEntityplatform_platform(`newEntity`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPlatform(platformId: Parameter<Int>, willReturn: Result<PlatformCollected?, DatabaseError>...) -> MethodStub {
            return Given(method: .m_getPlatform__platformId_platformId(`platformId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchAllPlatforms(willReturn: Result<[PlatformCollected], DatabaseError>...) -> MethodStub {
            return Given(method: .m_fetchAllPlatforms, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func replace(savedGame: Parameter<SavedGame>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_replace__savedGame_savedGame(`savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func remove(savedGame: Parameter<SavedGame>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_remove__savedGame_savedGame(`savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func remove(platform: Parameter<Platform>, willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_remove__platform_platform(`platform`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removeAll(willReturn: DatabaseError?...) -> MethodStub {
            return Given(method: .m_removeAll, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_add__newEntity_newEntityplatform_platform(`newEntity`, `platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
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
        public static func replace(savedGame: Parameter<SavedGame>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_replace__savedGame_savedGame(`savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func remove(savedGame: Parameter<SavedGame>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_remove__savedGame_savedGame(`savedGame`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func remove(platform: Parameter<Platform>, willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_remove__platform_platform(`platform`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
        public static func removeAll(willProduce: (Stubber<DatabaseError?>) -> Void) -> MethodStub {
            let willReturn: [DatabaseError?] = []
			let given: Given = { return Given(method: .m_removeAll, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseError?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>) -> Verify { return Verify(method: .m_add__newEntity_newEntityplatform_platform(`newEntity`, `platform`))}
        public static func getPlatform(platformId: Parameter<Int>) -> Verify { return Verify(method: .m_getPlatform__platformId_platformId(`platformId`))}
        public static func fetchAllPlatforms() -> Verify { return Verify(method: .m_fetchAllPlatforms)}
        public static func replace(savedGame: Parameter<SavedGame>) -> Verify { return Verify(method: .m_replace__savedGame_savedGame(`savedGame`))}
        public static func remove(savedGame: Parameter<SavedGame>) -> Verify { return Verify(method: .m_remove__savedGame_savedGame(`savedGame`))}
        public static func remove(platform: Parameter<Platform>) -> Verify { return Verify(method: .m_remove__platform_platform(`platform`))}
        public static func removeAll() -> Verify { return Verify(method: .m_removeAll)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func add(newEntity: Parameter<SavedGame>, platform: Parameter<Platform>, perform: @escaping (SavedGame, Platform) -> Void) -> Perform {
            return Perform(method: .m_add__newEntity_newEntityplatform_platform(`newEntity`, `platform`), performs: perform)
        }
        public static func getPlatform(platformId: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getPlatform__platformId_platformId(`platformId`), performs: perform)
        }
        public static func fetchAllPlatforms(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchAllPlatforms, performs: perform)
        }
        public static func replace(savedGame: Parameter<SavedGame>, perform: @escaping (SavedGame) -> Void) -> Perform {
            return Perform(method: .m_replace__savedGame_savedGame(`savedGame`), performs: perform)
        }
        public static func remove(savedGame: Parameter<SavedGame>, perform: @escaping (SavedGame) -> Void) -> Perform {
            return Perform(method: .m_remove__savedGame_savedGame(`savedGame`), performs: perform)
        }
        public static func remove(platform: Parameter<Platform>, perform: @escaping (Platform) -> Void) -> Perform {
            return Perform(method: .m_remove__platform_platform(`platform`), performs: perform)
        }
        public static func removeAll(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_removeAll, performs: perform)
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





    open func didTapPrimaryButton(with title: String?) {
        addInvocation(.m_didTapPrimaryButton__with_title(Parameter<String?>.value(`title`)))
		let perform = methodPerformValue(.m_didTapPrimaryButton__with_title(Parameter<String?>.value(`title`))) as? (String?) -> Void
		perform?(`title`)
    }


    fileprivate enum MethodType {
        case m_didTapPrimaryButton__with_title(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didTapPrimaryButton__with_title(let lhsTitle), .m_didTapPrimaryButton__with_title(let rhsTitle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "with title"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_didTapPrimaryButton__with_title(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didTapPrimaryButton__with_title: return ".didTapPrimaryButton(with:)"
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

        public static func didTapPrimaryButton(with title: Parameter<String?>) -> Verify { return Verify(method: .m_didTapPrimaryButton__with_title(`title`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didTapPrimaryButton(with title: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_didTapPrimaryButton__with_title(`title`), performs: perform)
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

    open func cancelButtonTapped(callback: @escaping (EmptyError?) -> ()) {
        addInvocation(.m_cancelButtonTapped__callback_callback(Parameter<(EmptyError?) -> ()>.value(`callback`)))
		let perform = methodPerformValue(.m_cancelButtonTapped__callback_callback(Parameter<(EmptyError?) -> ()>.value(`callback`))) as? (@escaping (EmptyError?) -> ()) -> Void
		perform?(`callback`)
    }


    fileprivate enum MethodType {
        case m_updateSearchTextField__with_textcallback_callback(Parameter<String>, Parameter<(EmptyError?) -> ()>)
        case m_startSearch__from_searchQuerycallback_callback(Parameter<String>, Parameter<(EmptyError?) -> ()>)
        case m_cancelButtonTapped__callback_callback(Parameter<(EmptyError?) -> ()>)

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

            case (.m_cancelButtonTapped__callback_callback(let lhsCallback), .m_cancelButtonTapped__callback_callback(let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_updateSearchTextField__with_textcallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_startSearch__from_searchQuerycallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_cancelButtonTapped__callback_callback(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_updateSearchTextField__with_textcallback_callback: return ".updateSearchTextField(with:callback:)"
            case .m_startSearch__from_searchQuerycallback_callback: return ".startSearch(from:callback:)"
            case .m_cancelButtonTapped__callback_callback: return ".cancelButtonTapped(callback:)"
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
        public static func cancelButtonTapped(callback: Parameter<(EmptyError?) -> ()>) -> Verify { return Verify(method: .m_cancelButtonTapped__callback_callback(`callback`))}
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
        public static func cancelButtonTapped(callback: Parameter<(EmptyError?) -> ()>, perform: @escaping (@escaping (EmptyError?) -> ()) -> Void) -> Perform {
            return Perform(method: .m_cancelButtonTapped__callback_callback(`callback`), performs: perform)
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

