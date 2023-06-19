/// A structure used to tag a given type.
///
/// ``Tagged`` is a type used to tag other types to distinguish the same ``RawValue``  types.
/// Two or more ``Tagged`` instances which have the same ``RawValue`` type (for example a String) can be tagged
/// using different ``Tag``types which, unlike a typealias, prevents them from interchangeable usage.
/// ``Tagged`` tries to mimic its ``RawValue`` type behavior using conditional conformances and dynamic member lookup.
///
/// Example usage of the ``Tagged`` struct:
///
/// ```swift
/// enum UsernameTag {}
/// enum PasswordTag {}
///
/// typealias Username = Tagged<String, UsernameTag>
/// typealias Password = Tagged<String, PasswordTag>
///
/// func log(_ username: Username, _ password: Password) {
///	...
/// }
///
/// let username: Username = "user@name.com"
/// let password: Password = "pa55w0rD"
///
/// authorized(username, password)
/// ```
/// In the example above authorize function arguments are using String values, but due to the different ``Tag`` types
/// those arguments can't be mismatched when the function is called.
@dynamicMemberLookup
public struct Tagged<RawValue, Tag> {

	// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
	// Documentation inherited from RawRepresentable.rawValue.
	public var rawValue: RawValue

	// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
	// Documentation inherited from RawRepresentable.init(rawValue:).
	@_transparent
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

	@inlinable
	public subscript<Value>(
		dynamicMember keyPath: KeyPath<RawValue, Value>
	) -> Value {
		self.rawValue[keyPath: keyPath]
	}
}

extension Tagged {

	/// Map current RawValue using a given function.
	///
	/// Create new instance of ``Tagged`` while changing its ``RawValue`` type and/or value using provided function. Mapping does not affect the ``Tag``.
	///
	/// - Parameter mapping: Function used to transform the current ``RawValue`` into a new one.
	/// - Returns: New instance of ``Tagged`` with the same ``Tag`` and transformed ``RawValue``.
	@_transparent
	public func map<Mapped>(
		_ mapping: (RawValue) throws -> Mapped
	) rethrows -> Tagged<Mapped, Tag> {
		try Tagged<Mapped, Tag>(
			rawValue: mapping(self.rawValue)
		)
	}

	/// Change Tag while keeping rawValue.
	///
	/// Create new instance of ``Tagged`` with the same rawValue but using provided NewTag type as its tag.
	///
	/// - Parameter tagged: ``Tagged`` type using the same ``RawValue`` type and required tag type.
	/// - Returns: New instance of ``Tagged`` with the same ``RawValue`` and changed ``Tag``.
	@_transparent
	public func retag<NewTag>(
		to tagged: Tagged<RawValue, NewTag>.Type
	) -> Tagged<RawValue, NewTag> {
		Tagged<RawValue, NewTag>(rawValue: self.rawValue)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: CustomStringConvertible {

	@_transparent
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

	@_transparent
	public var playgroundDescription: Any {
		self.rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: LosslessStringConvertible
where RawValue: LosslessStringConvertible {

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
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

	@_transparent
	public func encode(
		to encoder: Encoder
	) throws {
		try rawValue.encode(to: encoder)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Decodable
where RawValue: Decodable {

	@_transparent
	public init(
		from decoder: Decoder
	) throws {
		self.rawValue = try RawValue(from: decoder)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Equatable
where RawValue: Equatable {

	@_transparent
	public static func == (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue == rhs.rawValue
	}

	@_transparent
	public static func != (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue != rhs.rawValue
	}

	@_transparent
	public static func == (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs == rhs.rawValue
	}

	@_transparent
	public static func != (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs != rhs.rawValue
	}

	@_transparent
	public static func == (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue == rhs
	}

	@_transparent
	public static func != (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue != rhs
	}

	@_transparent
	public static func ~= (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs == rhs.rawValue
	}

	@_transparent
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

	@_transparent
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

	@_transparent
	public var startIndex: RawValue.Index {
		self.rawValue.startIndex
	}

	@_transparent
	public var endIndex: RawValue.Index {
		self.rawValue.endIndex
	}

	@_transparent
	public func makeIterator() -> RawValue.Iterator {
		self.rawValue.makeIterator()
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Comparable
where RawValue: Comparable {

	@_transparent
	public static func < (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue < rhs.rawValue
	}

	@_transparent
	public static func <= (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue <= rhs.rawValue
	}

	@_transparent
	public static func > (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue > rhs.rawValue
	}

	@_transparent
	public static func >= (
		_ lhs: Self,
		_ rhs: Self
	) -> Bool {
		lhs.rawValue >= rhs.rawValue
	}

	@_transparent
	public static func < (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue < rhs
	}

	@_transparent
	public static func <= (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue <= rhs
	}

	@_transparent
	public static func > (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue > rhs
	}

	@_transparent
	public static func >= (
		_ lhs: Self,
		_ rhs: RawValue
	) -> Bool {
		lhs.rawValue >= rhs
	}

	@_transparent
	public static func < (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs < rhs.rawValue
	}

	@_transparent
	public static func <= (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs <= rhs.rawValue
	}

	@_transparent
	public static func > (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs > rhs.rawValue
	}

	@_transparent
	public static func >= (
		_ lhs: RawValue,
		_ rhs: Self
	) -> Bool {
		lhs >= rhs.rawValue
	}
}

extension Tagged: Error
where RawValue: Error {}

extension Tagged: Sendable
where RawValue: Sendable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: Identifiable
where RawValue: Identifiable {

	@_transparent
	public var id: RawValue.ID {
		self.rawValue.id
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Tagged: AdditiveArithmetic
where RawValue: AdditiveArithmetic {

	@_transparent @_semantics("constant_evaluable")
	public static var zero: Self {
		Self(rawValue: .zero)
	}

	@_transparent
	public static func + (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		Self(
			rawValue: lhs.rawValue + rhs.rawValue
		)
	}

	@_transparent
	public static func += (
		_ lhs: inout Self,
		_ rhs: Self
	) {
		lhs.rawValue += rhs.rawValue
	}

	@_transparent
	public static func - (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		Self(
			rawValue: lhs.rawValue - rhs.rawValue
		)
	}

	@_transparent
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

	@_transparent
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

	@_transparent
	public var magnitude: RawValue.Magnitude {
		self.rawValue.magnitude
	}

	@_transparent
	public static func * (
		_ lhs: Self,
		_ rhs: Self
	) -> Self {
		Self(
			rawValue: lhs.rawValue * rhs.rawValue
		)
	}

	@_transparent
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

	@_transparent
	public func distance(
		to other: Self
	) -> RawValue.Stride {
		self.rawValue.distance(to: other.rawValue)
	}

	@_transparent
	public func advanced(
		by n: RawValue.Stride
	) -> Self {
		Self(
			rawValue: self.rawValue.advanced(by: n)
		)
	}
}
