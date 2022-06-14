@dynamicMemberLookup
public struct Tagged<RawValue, Tag> {

	public var rawValue: RawValue

	public init(
		rawValue: RawValue
	) {
		self.rawValue = rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: RawRepresentable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged {

	public subscript<Value>(
		dynamicMember keyPath: KeyPath<RawValue, Value>
	) -> Value {
		self.rawValue[keyPath: keyPath]
	}
}

extension Tagged {

	public func map<Mapped>(
		_ mapping: (RawValue) throws -> Mapped
	) rethrows -> Tagged<Mapped, Tag> {
		try .init(
			rawValue: mapping(self.rawValue)
		)
	}

	public func retag<NewTag>(
		to: Tagged<RawValue, NewTag>.Type
	) -> Tagged<RawValue, NewTag> {
		.init(rawValue: self.rawValue)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: CustomStringConvertible {

	public var description: String {
		String(describing: self.rawValue)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: CustomDebugStringConvertible {

	public var debugDescription: String {
		"Tagged<\(RawValue.self), \(Tag.self)>\((self.rawValue as? CustomDebugStringConvertible).map(\.debugDescription) ?? String(describing: self.rawValue))"
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: CustomPlaygroundDisplayConvertible {

	public var playgroundDescription: Any {
		self.rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: LosslessStringConvertible
where RawValue: LosslessStringConvertible {

	public init?(
		_ description: String
	) {
		guard let rawValue = RawValue(description)
		else { return nil }
		self.init(rawValue: rawValue)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByUnicodeScalarLiteral
where RawValue: ExpressibleByUnicodeScalarLiteral {

	public init(
		unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType
	) {
		self.init(
			rawValue: RawValue(
				unicodeScalarLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral
where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {

	public init(
		extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType
	) {
		self.init(
			rawValue: RawValue(
				extendedGraphemeClusterLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByStringLiteral
where RawValue: ExpressibleByStringLiteral {

	public init(
		stringLiteral value: RawValue.StringLiteralType
	) {
		self.init(
			rawValue: RawValue(
				stringLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByStringInterpolation
where RawValue: ExpressibleByStringInterpolation {

	public init(
		stringInterpolation value: RawValue.StringInterpolation
	) {
		self.init(
			rawValue: RawValue(
				stringInterpolation: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByBooleanLiteral
where RawValue: ExpressibleByBooleanLiteral {

	public init(
		booleanLiteral value: RawValue.BooleanLiteralType
	) {
		self.init(
			rawValue: RawValue(
				booleanLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByIntegerLiteral
where RawValue: ExpressibleByIntegerLiteral {

	public init(
		integerLiteral value: RawValue.IntegerLiteralType
	) {
		self.init(
			rawValue: RawValue(
				integerLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByFloatLiteral
where RawValue: ExpressibleByFloatLiteral {

	public init(
		floatLiteral value: RawValue.FloatLiteralType
	) {
		self.init(
			rawValue: RawValue(
				floatLiteral: value
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByNilLiteral
where RawValue: ExpressibleByNilLiteral {

	public init(
		nilLiteral: Void
	) {
		self.init(
			rawValue: RawValue(
				nilLiteral: Void()
			)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByArrayLiteral
where RawValue: ExpressibleByArrayLiteral {

	public init(
		arrayLiteral elements: RawValue.ArrayLiteralElement...
	) {
		self.init(
			rawValue: unsafeBitCast(
				RawValue.init(arrayLiteral:) as (ArrayLiteralElement...) -> RawValue,
				to: ((Array<ArrayLiteralElement>) -> RawValue).self
			)(elements)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: ExpressibleByDictionaryLiteral
where RawValue: ExpressibleByDictionaryLiteral {

	public init(
		dictionaryLiteral elements: (RawValue.Key, RawValue.Value)...
	) {
		self.init(
			rawValue: unsafeBitCast(
				RawValue.init(dictionaryLiteral:) as ((RawValue.Key, RawValue.Value)...) -> RawValue,
				to: ((Array<(RawValue.Key, RawValue.Value)>) -> RawValue).self
			)(elements)
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Encodable
where RawValue: Encodable {

	public func encode(to encoder: Encoder) throws {
		try rawValue.encode(to: encoder)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Decodable
where RawValue: Decodable {

	public init(from decoder: Decoder) throws {
		self.rawValue = try RawValue(from: decoder)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Equatable
where RawValue: Equatable {

	public static func == (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs == rhs.rawValue
	}

	public static func == (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue == rhs
	}

	public static func ~= (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs == rhs.rawValue
	}

	public static func ~= (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue == rhs
	}
}

extension Tagged: Hashable
where RawValue: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Collection
where RawValue: Collection {

	public func index(
		after idx: RawValue.Index
	) -> RawValue.Index {
		self.rawValue.index(after: idx)
	}

	public subscript(
		position: RawValue.Index
	) -> RawValue.Element {
		self.rawValue[position]
	}

	public var startIndex: RawValue.Index {
		self.rawValue.startIndex
	}

	public var endIndex: RawValue.Index {
		self.rawValue.endIndex
	}

	public func makeIterator() -> RawValue.Iterator {
		self.rawValue.makeIterator()
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Comparable
where RawValue: Comparable {

	public static func < (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

extension Tagged: Error
where RawValue: Error {}

extension Tagged: Sendable
where RawValue: Sendable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Identifiable
where RawValue: Identifiable {

	public var id: RawValue.ID {
		self.rawValue.id
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: AdditiveArithmetic
where RawValue: AdditiveArithmetic {

	public static var zero: Self {
		.init(rawValue: .zero)
	}

	public static func + (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		.init(
			rawValue: lhs.rawValue + rhs.rawValue
		)
	}

	public static func += (
		_ lhs: inout Self,
		_ rhs: Self
	) {
		lhs.rawValue += rhs.rawValue
	}

	public static func - (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		.init(
			rawValue: lhs.rawValue - rhs.rawValue
		)
	}

	public static func -= (
		_ lhs: inout Self,
		_ rhs: Self
	) {
		lhs.rawValue -= rhs.rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Numeric
where RawValue: Numeric {

	public init?<Source>(
		exactly source: Source
	) where Source: BinaryInteger {
		if let rawValue = RawValue(exactly: source) {
			self.init(rawValue: rawValue)
		}
		else {
			return nil
		}
	}

	public var magnitude: RawValue.Magnitude {
		self.rawValue.magnitude
	}

	public static func * (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		.init(
			rawValue: lhs.rawValue * rhs.rawValue
		)
	}

	public static func *= (
		_ lhs: inout Self,
		_ rhs: Self
	) {
		lhs.rawValue *= rhs.rawValue
	}
}

extension Tagged: SignedNumeric
where RawValue: SignedNumeric {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Sequence
where RawValue: Sequence {

	public func makeIterator() -> RawValue.Iterator {
		self.rawValue.makeIterator()
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: AsyncSequence
where RawValue: AsyncSequence {

	public typealias AsyncIterator = RawValue.AsyncIterator
	public typealias Element = RawValue.Element

	public func makeAsyncIterator() -> RawValue.AsyncIterator {
		self.rawValue.makeAsyncIterator()
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Strideable
where RawValue: Strideable {

	public func distance(
		to other: Self
	) -> RawValue.Stride {
		self.rawValue.distance(to: other.rawValue)
	}

	public func advanced(
		by n: RawValue.Stride
	) -> Self {
		.init(
			rawValue: self.rawValue.advanced(by: n)
		)
	}
}
