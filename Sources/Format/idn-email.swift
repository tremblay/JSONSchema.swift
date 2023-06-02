import Foundation

func isValidIDNEmail(_ value: String) -> Bool {
  // Using the regex from https://gist.github.com/baker-ling/3b4b014ee809aa9732f9873fe060c098


  let pattern = #"""
  /^(?<localPart>(?<dotString>[0-9a-z!#$%&'*+-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+(\.[0-9a-z!#$%&'*+-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+)*)|(?<quotedString>"([\x20-\x21\x23-\x5B\x5D-\x7E\u{80}-\u{10FFFF}]|\\[\x20-\x7E])*"))(?<!.{64,})@(?<domainOrAddressLiteral>(?<addressLiteral>\[((?<IPv4>\d{1,3}(\.\d{1,3}){3})|(?<IPv6Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){7})|(?<IPv6Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?)|(?<IPv6v4Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){5}:\d{1,3}(\.\d{1,3}){3})|(?<IPv6v4Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3}:)?\d{1,3}(\.\d{1,3}){3})|(?<generalAddressLiteral>[a-z0-9-]*[[a-z0-9]:[\x21-\x5A\x5E-\x7E]+))\])|(?<Domain>(?!.{256,})(([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))(\.([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))*))$/iu
  """#

  if let expression = try? NSRegularExpression(pattern: pattern, options: []) {
    let result = expression.matches(in: value, options: [], range: NSMakeRange(0, value.utf16.count))
    if result.count == 1 {
      let foundRange = result[0].range
      if foundRange.location == 0 && foundRange.length == value.utf16.count {
        return true
      }
    }
  }

  return false
}

func validateIDNEmail(_ context: Context, _ value: String) -> AnySequence<ValidationError> {
  if isValidIDNEmail(value) {
    return AnySequence(EmptyCollection())
  }

  return AnySequence([
    ValidationError(
      "'\(value)' is not a valid RFC 6531 internationalized email address.",
      instanceLocation: context.instanceLocation,
      keywordLocation: context.keywordLocation
    )
  ])
}
