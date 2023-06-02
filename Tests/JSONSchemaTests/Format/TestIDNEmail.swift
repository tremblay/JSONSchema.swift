import Spectre
@testable import JSONSchema


public let testIDNEmailFormat: ((ContextType) -> Void) = {
  $0.describe("email") { // emails from https://en.wikipedia.org/wiki/Email_address#Examples
    $0.it("allows valid email") {
      try expect(isValidIDNEmail("simple@example.com")).to.beTrue()
      try expect(isValidIDNEmail("very.common@example.com")).to.beTrue()
      try expect(isValidIDNEmail("disposable.style.email.with+symbol@example.com")).to.beTrue()
      try expect(isValidIDNEmail("other.email-with-hyphen@and.subdomains.example.com")).to.beTrue()
      try expect(isValidIDNEmail("fully-qualified-domain@example.com")).to.beTrue()
      try expect(isValidIDNEmail("user.name+tag+sorting@example.com")).to.beTrue()
      try expect(isValidIDNEmail("x@example.com")).to.beTrue()
      try expect(isValidIDNEmail("example-indeed@strange-example.com")).to.beTrue()
      try expect(isValidIDNEmail("test/test@test.com")).to.beTrue()
      try expect(isValidIDNEmail("admin@mailserver1")).to.beTrue()
      try expect(isValidIDNEmail("example@s.example")).to.beTrue()
      try expect(isValidIDNEmail("\" \"@example.org")).to.beTrue()
      try expect(isValidIDNEmail("\"john..doe\"@example.org")).to.beTrue()
      try expect(isValidIDNEmail("mailhost!username@example.org")).to.beTrue()
      try expect(isValidIDNEmail("\"very.(),:;<>[]\\\".VERY.\\\"very@\\\\ \\\"very\\\".unusual\"@strange.example.com")).to.beTrue()
      try expect(isValidIDNEmail("user%example.com@example.org")).to.beTrue()
      try expect(isValidIDNEmail("user-@example.org")).to.beTrue()
      try expect(isValidIDNEmail("postmaster@[123.123.123.123]")).to.beTrue()
      try expect(isValidIDNEmail("postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]")).to.beTrue()
    }

    $0.it("fails validation with invalid email") {
      try expect(isValidIDNEmail("Abc.example.com")).to.beFalse()
      try expect(isValidIDNEmail("A@b@c@example.com")).to.beFalse()
      try expect(isValidIDNEmail("a\"b(c)d,e:f;g<h>i[j\\k]l@example.com")).to.beFalse()
      try expect(isValidIDNEmail("just\"not\"right@example.com")).to.beFalse()
      try expect(isValidIDNEmail("this is\"not\\allowed@example.com")).to.beFalse()
      try expect(isValidIDNEmail("this\\ still\\\"not\\\\allowed@example.com")).to.beFalse()
      try expect(isValidIDNEmail("1234567890123456789012345678901234567890123456789012345678901234+x@example.com")).to.beFalse()
      try expect(isValidIDNEmail("i_like_underscore@but_its_not_allowed_in_this_part.example.com")).to.beFalse()
      try expect(isValidIDNEmail("QA[icon]CHOCOLATE[icon]@test.com")).to.beFalse()
    }
  }
}
