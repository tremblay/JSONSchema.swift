import Spectre
@testable import JSONSchema


public let testEmailFormat: ((ContextType) -> Void) = {
  $0.describe("email") { // emails from https://en.wikipedia.org/wiki/Email_address#Examples
    $0.it("allows valid email") {
      try expect(isValidEmail("simple@example.com")).to.beTrue()
      try expect(isValidEmail("very.common@example.com")).to.beTrue()
      try expect(isValidEmail("disposable.style.email.with+symbol@example.com")).to.beTrue()
      try expect(isValidEmail("other.email-with-hyphen@and.subdomains.example.com")).to.beTrue()
      try expect(isValidEmail("fully-qualified-domain@example.com")).to.beTrue()
      try expect(isValidEmail("user.name+tag+sorting@example.com")).to.beTrue()
      try expect(isValidEmail("x@example.com")).to.beTrue()
      try expect(isValidEmail("example-indeed@strange-example.com")).to.beTrue()
      try expect(isValidEmail("test/test@test.com")).to.beTrue()
      try expect(isValidEmail("admin@mailserver1")).to.beTrue()
      try expect(isValidEmail("example@s.example")).to.beTrue()
      try expect(isValidEmail("\" \"@example.org")).to.beTrue()
      try expect(isValidEmail("\"john..doe\"@example.org")).to.beTrue()
      try expect(isValidEmail("mailhost!username@example.org")).to.beTrue()
      try expect(isValidEmail("\"very.(),:;<>[]\\\".VERY.\\\"very@\\\\ \\\"very\\\".unusual\"@strange.example.com")).to.beTrue()
      try expect(isValidEmail("user%example.com@example.org")).to.beTrue()
      try expect(isValidEmail("user-@example.org")).to.beTrue()
      try expect(isValidEmail("postmaster@[123.123.123.123]")).to.beTrue()
      try expect(isValidEmail("postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]")).to.beTrue()
    }

    $0.it("fails validation with invalid email") {
      try expect(isValidEmail("Abc.example.com")).to.beFalse()
      try expect(isValidEmail("A@b@c@example.com")).to.beFalse()
      try expect(isValidEmail("a\"b(c)d,e:f;g<h>i[j\\k]l@example.com")).to.beFalse()
      try expect(isValidEmail("just\"not\"right@example.com")).to.beFalse()
      try expect(isValidEmail("this is\"not\\allowed@example.com")).to.beFalse()
      try expect(isValidEmail("this\\ still\\\"not\\\\allowed@example.com")).to.beFalse()
      try expect(isValidEmail("1234567890123456789012345678901234567890123456789012345678901234+x@example.com")).to.beFalse()
      try expect(isValidEmail("i_like_underscore@but_its_not_allowed_in_this_part.example.com")).to.beFalse()
      try expect(isValidEmail("QA[icon]CHOCOLATE[icon]@test.com")).to.beFalse()
    }
  }
}
