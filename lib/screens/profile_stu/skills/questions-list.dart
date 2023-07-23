import '../../../Models/question_model.dart';

class CPP {
  static final List<Question> questions = [
    Question(
        id: '1',
        title:
            'Which of the following keywords is used to write assembly code in a C ++ program?',
        options: {
          'ASM': false,
          'asm': true,
          'Not Possible': false,
          'Compiler Specific': false
        }),
    Question(
        id: '2',
        title:
            'Which one of the following is considered as the least safe typecasting in C++?',
        options: {
          'const_cast': false,
          'reinterpret_cast': true,
          'dynamic_cast': false,
          'None of the above': false
        }),
    Question(
        id: '3',
        title: 'ISO/IEC 14882:1998 addresses which version of C++?',
        options: {
          'C++ 98': true,
          'C++ 93': false,
          'C++ 0': false,
          'C++ 03': false
        }),
    Question(
        id: '4',
        title:
            'Which one of the following correctly refers to the command line arguments?',
        options: {
          'Arguments passed to the main() function': true,
          'Arguments passed to the structure-function': false,
          'Arguments passed to the class function': false,
          'Arguments passed to the any function': false
        }),
    Question(
        id: '5',
        title:
            'Which of the following methods can be considered the correct and efficient way of handling arguments with spaces?',
        options: {
          'Use single quotes': false,
          'Either single or double quotes': true,
          'Use double quotes': false,
          'There is no way of handling arguments with space': false
        }),
  ];
}

class Flutter {
  static final List<Question> questions = [
    Question(
        id: '1',
        title: 'Which of the following is true regarding Flutter?',
        options: {
          'Flutter is a UI toolkit for creating fast, beautiful, natively compiled mobile applications':
              false,
          ' Flutter use one programming language and a single codebase': false,
          'Flutter is free and open-source.': false,
          'All of the above': true
        }),
    Question(id: '2', title: 'Flutter developed by', options: {
      'Oracle': false,
      'Facebook': false,
      'Google': true,
      'IBM': false
    }),
    Question(
        id: '3',
        title: 'Flutter is not a language; it is an SDK.',
        options: {
          'True': true,
          'False': false,
          'Can be true or false': false,
          'Can not say': false
        }),
    Question(
        id: '4',
        title: 'The first alpha version of Flutter was released in',
        options: {'2016': false, '2017': true, '2018': false, '2019': false}),
    Question(
        id: '5',
        title:
            'Flutter is mainly optimized for 2D mobile apps that can run on?',
        options: {
          'Android': false,
          'iOS': false,
          'Both A and B': true,
          'None of the above': false
        }),
  ];
}

class Python {
  static final List<Question> questions = [
    Question(
        id: '1',
        title: 'Who developed Python Programming Language?',
        options: {
          'Wick van Rossum': false,
          'Rasmus Lerdorf': false,
          'Guido van Rossum': true,
          'Niene Stom': false,
        }),
    Question(
        id: '2',
        title: 'Which type of Programming does Python support?',
        options: {
          ' object-oriented programming': false,
          'structured programming': false,
          'functional programming': false,
          'all of the mentioned': true
        }),
    Question(
        id: '3',
        title: 'Is Python case sensitive when dealing with identifiers?',
        options: {
          'no': false,
          'yes': true,
          'machine dependent': false,
          'none of the mentioned': false
        }),
    Question(
        id: '4',
        title:
            'Which of the following is the correct extension of the Python file?',
        options: {'.python': false, '.pl': false, ' .py': true, '.p': false}),
    Question(
        id: '5',
        title: 'Is Python code compiled or interpreted?',
        options: {
          'Python code is both compiled and interpreted': true,
          'Python code is neither compiled nor interpreted': false,
          'Python code is only compiled': false,
          'Python code is only interpreted': false
        }),
  ];
}
