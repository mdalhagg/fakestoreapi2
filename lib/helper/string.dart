extension StringHelper on String {
  String toNormal() {
    String output = this;
    output = output.replaceAllMapped(
      RegExp(r'([A-Z])|_+'),
      (Match match) {
        if (match.group(1) != null) {
          return ' ${match.group(1)}';
        } else {
          return ' ';
        }
      },
    );

    return output;
  }

  String replaceArabicNumerals() {
    String text = this;
    // Define a map of Arabic numerals and their corresponding English numerals
    Map<String, String> numerals = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    // Replace each Arabic numeral with its corresponding English numeral
    numerals.forEach((key, value) {
      text = text.replaceAll(key, value);
    });

    return text;
  }
}

Map<String, String> daysMap = {
  'Sunday': 'الاحد',
  'Monday': 'الاثنين',
  'Tuesday': 'الثلاثاء',
  'Wednesday': 'الاربعاء',
  'Thursday': 'الخميس',
  'Friday': 'الجمعة',
  'Saturday': 'السبت',
};
