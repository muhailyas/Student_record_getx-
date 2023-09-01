bool isValidName(String input) {
  return input.isNotEmpty;
}

bool isValidAge(String input) {
  try {
    int age = int.parse(input);
    if (age > 0 && age <= 120) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

bool isValidBatch(String input) {
  try {
    int batch = int.parse(input);
    if (batch >= 0 && batch <= 120) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

bool isValidMobileNumber(String input) {
  try {
    int.parse(input);
    return input.length == 10 ? true : false;
  } catch (e) {
    return false;
  }
}

bool isValidEmail(String input) {
  return input.contains('@gmail.com');
}

validateFunctions(Function function, String input) {
  if (function == isValidName) {
    return isValidName(input.trim());
  } else if (function == isValidAge) {
    return isValidAge(input);
  } else if (function == isValidBatch) {
    return isValidBatch(input);
  } else if (function == isValidMobileNumber) {
    return isValidMobileNumber(input);
  } else {
    return isValidEmail(input);
  }
}
