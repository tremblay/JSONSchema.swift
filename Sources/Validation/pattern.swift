import Foundation


func pattern(context: Context, pattern: Any, instance: Any, schema: [String: Any]) -> AnySequence<ValidationError> {
  guard let pattern = pattern as? String else {
    return AnySequence(EmptyCollection())
  }

  guard let instance = instance as? String else {
    return AnySequence(EmptyCollection())
  }

  guard let expression = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0)) else {
    return AnySequence(["[Schema] Regex pattern '\(pattern)' is not valid"])
  }

  let range = NSMakeRange(0, instance.count)
  if expression.matches(in: instance, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range).count == 0 {
    return AnySequence(["'\(instance)' does not match pattern: '\(pattern)'"])
  }

  return AnySequence(EmptyCollection())
}
