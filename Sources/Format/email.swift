import Foundation

func isValidEmail(_ value: String) -> Bool {
  // Using the regex from https://stackoverflow.com/a/26989421

  let pattern = #"""
  ([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|"([]!#-[^-~ \t]|(\\[\t -~]))+")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])
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

func validateEmail(_ context: Context, _ value: String) -> AnySequence<ValidationError> {
  if isValidEmail(value) {
    return AnySequence(EmptyCollection())
  }

  return AnySequence([
    ValidationError(
      "'\(value)' is not a valid RFC 5321 email address.",
      instanceLocation: context.instanceLocation,
      keywordLocation: context.keywordLocation
    )
  ])
}
