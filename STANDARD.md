# VZL Standard

> Copyright (C)  2026-06-21 Cristian Guilarte.
> Permission is granted to copy, distribute and/or modify this document
> under the terms of the GNU Free Documentation License, Version 1.3
> or any later version published by the Free Software Foundation;
> with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
> A copy of the license is included in the section entitled "GNU
> Free Documentation License".

# Table of Contents
- [Purpose](#purpose)
- [Philosophy](#philosophy)
- [Versions](#versions)
- [Header Files](#header_files)
- [Scoping](#scoping)
- [Comments](#comments)
- [Naming](#naming)
- [Choosing Names](#choosing_names)
- [File Names](#file_names)
- [Type Names](#type_names)
- [Variable Names](#variable_names)
- [Constant Names](#constant_names)
- [Object Names](#object_names)
- [Structure Names](#structure_names)
- [Union Names](#union_names)
- [Enumerator Names](#enumerator_names)
- [Macro Names](#macro_names)
- [Function Names](#function_names)
- [Functions](Functions)
- [Input & Output](#input_&_output)
- [Inclusive Language](#inclusive_language)
- [Formatting](#formatting)
- [Tests](#tests)

# Purpose
# Philosophy
- KISS
- MIE

# Versions
## C
Aim to write code executable in C23 while avoiding using extensively features that not supported in
at least C99.

## SemVer
Follow SemVer but add the suffix `alpha` (debug), `beta` (testing), `gamma` (release candidate), `delta` (gold distribution), `omega` (end of life).

# Header Files
Every `.c` file should have a `.h` associated, unless it is a unit test.

## Define Guard
All headers, independently of its function, must have a guard like the following:

```c
#define   HEADER_FILE
#ifndef   HEADER_FILE
...
#endif // HEADER_FILE
```

`HEADER_FILE` must be replace following the context and [naming](#macro_names) rules.

## Definition
Do not define objects nor functions in header file. Only constants and macros.
Be sure to use the `extern` keyword for variables and other non-function objects, like structures
or unions.

## Essentials includes
If a source or header file refers to a symbol defined elsewhere, the file should directly include
a header file which properly intends to provide a declaration or definition of that symbol.
It should not include header files for any other reason.

Do not rely on transitive inclusions. This allows people to remove no-longer-needed #include
statements from their headers without breaking clients. This also applies to related headers -
foo.cc should include bar.h if it uses a symbol from it even if foo.h includes bar.h.

## Forward Declarations
Avoid using forward declarations where possible.

## Include order
1. C system headers
2. C standard headers
3. Related headers or third-party headers
4. Project's headers
5. Other headers

All includes must not use relative path syntax ("./" or "../").

These includes should be at the beginning of the file and should grouped in, leaving an empty line
between each rank.

### Exception
Conditional includes are free from the latter norm, although they must follow the corresponding
order.

# Scoping
## Namespace
- Follow the rule on [namespace names](#namespace_names).
- Always use namespaces in both declaration and implementation files.

> No matter what the situation is, use namespaces.

## Local Variables
- Place a function's variables in the narrowest scope possible.
- Always initialise variables and constants at the top of the scope.
- Do not split the declaration from the initialisation.
- Always use a variable next to its initialisation.

## Global Variables
- Avoid using `static` and/or global variables as much as possible.

In case it is strictly necessary, use constants with the `constexpr` (or `static` for
non-constants) keyword and place them at the top of the file, or scope.

## Declaration order
1. Types and type aliases (typedef, using, enum, nested structs)
2. (Optionally, for structs only) non-static data members
3. Static constants
4. Factory functions
5. Constructors
6. Destructor
7. All other functions (static and non-static member functions)
8. All other data members (static and non-static)

# Comments
Comments are absolutely vital to keeping our code readable. The following rules describe what you should comment and where. But remember: while comments are very important, the best code is self-documenting. Giving sensible names to types and variables is much better than using obscure names that you must then explain through comments.

When writing your comments, write for your audience: the next contributor who will need to understand your code. Be generous — the next one may be you!

Use one-line comments (`//`), nerver multi-line comments (`/**/`).

## File Comments
Start each file with license boilerplate.
If a source file (such as a .h file) declares multiple user-facing abstractions (common functions, related classes, etc.), include a comment describing the collection of those abstractions. Include enough detail for future authors to know what does not fit there. However, the detailed documentation about individual abstractions belongs with those abstractions, not at the file level.

## TODO Comments
Use TODO comments for code that is temporary, a short-term solution, or good-enough but not perfect.

TODOs should include the string TODO in all caps, followed by the bug ID, name, e-mail address, or other identifier of the person or issue with the best context about the problem referenced by the TODO.

```c
// TODO: bug 12345678 - Remove this after the 2047q4 compatibility window expires.
// TODO: example.com/my-design-doc - Manually fix up this code the next time it's touched.
// TODO(bug 12345678): Update this list after the Foo service is turned down.
// TODO(John): Use a "\*" here for concatenation operator.
```

# Naming
For the purposes of the naming rules below, a "word" is anything that you would write in English without internal spaces. Either words are all lowercase, with underscores between words ("snake_case"), or words are mixed case with the first letter of each word capitalized ("camelCase" or "PascalCase").

## Choosing Names
Give things names that make their purpose or intent understandable to a new reader, even someone on a different team than the owners. Do not worry about saving horizontal space as it is far more important to make your code immediately understandable by a new reader.

Consider the context in which the name will be used. A name should be descriptive even if it is used far from the code that makes it available for use. However, a name should not distract the reader by repeating information that's present in the immediate context. Generally, this means that descriptiveness should be proportional to the name's scope of visibility. A free function declared in a header should probably mention the header's library, while a local variable probably shouldn't explain what function it's within.

Minimize the use of abbreviations that would likely be unknown to someone outside your project (especially acronyms and initialisms). Do not abbreviate by deleting letters within a word. When an abbreviation is used, prefer to uppercase it as a single "word", e.g., StartRPC() rather than StartRpc(). As a rule of thumb, an abbreviation is probably OK if it's listed in Wikipedia. Note that certain universally-known abbreviations are OK, such as i for a loop index.

The names you see most frequently are not like most names; a small number of "vocabulary" names are reused so widely that they are always in context. These names tend to be short or even abbreviated and their full meaning comes from explicit long-form documentation rather than from just comments on their definition and the words within the names.

## File Names
Filenames should be all lowercase and can include underscore (`_`). For example: `my_useful_file.c`.
Do not use filenames that already exist in `/usr/include`, such as `db.h`.
C files should have a .c filename extension, and header files should have a .h extension.
Make your filenames very specific. The recommended template is `<module>_<purpose>_<filename>.c`;
where `<module>` is the module's name, `<purpose>` is in what the file in being used for,
and `<filename>` (guess what that means).
For example, use `http_server_logs.h` rather than `logs.h`. This is a header file under de http module,
used in the server implementation that is called "logs".

## Type Names
- PascalCase
`ModuleNameType` -> `ServerConnectionStruct`

## Variable Names
- snake_case
For local: `use_a_short_name`.
For gloabal: `<module>_<name>`.

### Constant Names
- UPPER_CASE
For local: `USE_A_SHORT_NAME`.
For gloabal: `<MODULE>_<NAME>`.

## Object Names
Structure, Union, Enumerator Names are the same as Type Names.

### Macro Names
Just like Constant Names.

## Function Names
- camelCase

## Namespace Names

# Functions
## Input & Output
- Use return values over output parameters.
- Prefer to return by value or, failing that, return by reference. Avoid returning a raw pointer
unless it can be null (`nullptr`).
- Check edge cases and undesired values from the input parameters.
- Use constant input values (even pointers) when just reading, use input parameters by value
otherwise, and only use input parameters by reference when strictly necessary.

# Other Features
## Preincrement and Predecrement
- Use the prefix form (++i) of the increment and decrement operators unless you need postfix
semantics.

## Use of const
- Always write `const` on the right side.
    - Instead of this: `int cont * cont foo` or `int const bar`
    - Do this: `cont int * cont foo` or `const int bar`

- In APIs, use const whenever it makes sense. constexpr is a better choice for some uses of const.

## Typedef
- Avoid using `typedef`.

## Integer Types
- Prefer to use types define in `stdint.h` and `stdbool.h`.

## Macros
Do not use macros, use instead:
- `constexpr` for constants
- `inline` for short utility functions

If there is a justified reason for use a macro follow this rules:
1. Do not define macros in header files
2. `#define MACRO`, then use it, then `#undef MACRO`
3. Do not overwrite macros, use different names instead
4. Prefer not using ## to generate function/class/variable names

## nullptr over NULL
Use `nullptr` and `nullptr_t` for null pointers, and '\0' for null chars.

## sizeof
Prefer sizeof(varname) to sizeof(type).

## Type Deduction
Use type deduction only if it makes the code clearer to readers who aren't familiar with the project,
or if it makes the code safer. Do not use it merely to avoid the inconvenience of writing an explicit
type.

## Switch Statements
If not conditional on an enumerated value, switch statements should always have a default case (in the case of an enumerated value, the compiler will warn you if any values are not handled). If the default case should never execute, treat this as an error.
Fall-through from one case label to another must be annotated using the \[\[fallthrough\]\]; attribute. \[\[fallthrough\]\]; should be placed at a point of execution where a fall-through to the next case label occurs. A common exception is consecutive case labels without intervening code, in which case no annotation is needed.

# Inclusive Language
> Give a fuck about how other people feel when reading your code. It is code for a computer program, not a UNICEF petition.

Be laconic.

# Formatting
## Line Length
Each line of text in your code should be at most 80 characters long.

## Non-ASCII Characters
Non-ASCII characters should be rare, and must use UTF-8 formatting.

You shouldn't hard-code user-facing text in source, even English, so use of non-ASCII characters should be rare. However, in certain cases it is appropriate to include such words in your code. For example, if your code parses data files from foreign sources, it may be appropriate to hard-code the non-ASCII string(s) used in those data files as delimiters. More commonly, unit test code (which does not need to be localized) might contain non-ASCII strings. In such cases, you should use UTF-8, since that is an encoding understood by most tools able to handle more than just ASCII.

Hex encoding is also OK, and encouraged where it enhances readability — for example, "\xEF\xBB\xBF", or, even more simply, "\uFEFF", is the Unicode zero-width no-break space character, which would be invisible if included in the source as straight UTF-8.

You shouldn't use char16_t and char32_t character types, since they're for non-UTF-8 text. For similar reasons you also shouldn't use wchar_t (unless you're writing code that interacts with the Windows API, which uses wchar_t extensively).

## Spaces and Tabs
Use tabs (equivalent to 8 whitespaces) for indent and spaces for alignment.

## Function Declarations and Definitions
Line 1: modifiers (static, inline, extern).
Line 2: types (const, char*).
Line 3: function name.

1. Choose good parameter names.
2. A parameter name may be omitted only if the parameter is not used in the function's definition.
3. The return type and the function name on different lines, break between them.
4. Do not indent after the return type of a function declaration or definition.
5. The open parenthesis is always on the same line as the function name.
6. There is never a space between the function name and the open parenthesis.
7. There is always a space between the parentheses and the parameters.
8. The open curly brace is always at the start of the next line of the function declaration, not on the end of the last line.
9. The close curly brace is on the last line by itself.
10. All parameters should be aligned if possible.
11. Default indentation is 8 spaces.
12. Wrapped parameters have a 8 space indent.

```c
extern inline
uint32_t const
checkThisFunction( char const * const string,
                   uint32_t const code,
                   enum Status const status )
{
// CODE HERE
}
```

## Floating-point Literals
Floating-point literals should always have a radix point, with digits on both sides, even if they use exponential notation. Readability is improved if all floating-point literals take this familiar form, as this helps ensure that they are not mistaken for integer literals, and that the E/e of the exponential notation is not mistaken for a hexadecimal digit. It is fine to initialize a floating-point variable with an integer literal (assuming the variable type can exactly represent that integer), but note that a number in exponential notation is never an integer literal.

```c
float f = 1.0f;
float f2 = 1.0;  // Also OK
float f3 = 1;    // Also OK
long double ld = -0.5L;
double d = 1248.0e6;
```

Documentation Structure

    planning/ - Strategic planning documents
        Roadmaps, project plans, and timelines
        Development priorities and milestone tracking
        TODO lists and implementation plans
        Strategic recommendations and design principles
    specifications/ - Detailed technical specifications
        Feature specifications and requirements
        Data models and schemas
        Integration protocols
    architecture/ - Architectural documentation
        System architecture diagrams
        Component relationships
        /adr - Architecture Decision Records
            Documented decisions with context and consequences
    guides/ - User and developer documentation
        /user - End-user documentation
            Installation instructions
            Usage guides and tutorials
            CLI reference
        /dev - Developer documentation
            Contributing guidelines
            Development environment setup
            Code organization
    api/ - API documentation
        Function and module references
        Integration examples
        API schemas and usage

Documentation Workflow

    Specification Phase
        Create feature specifications in /specifications
        Document architectural decisions in /architecture/adr
        Define requirements and acceptance criteria
    Planning Phase
        Develop implementation plans in /planning
        Break down features into actionable tasks
        Establish timelines and priorities
    Development Phase
        Reference specifications during implementation
        Update API documentation as code evolves
        Document developer guides for new components
    Release Phase
        Finalize user documentation in /guides/user
        Update README and quick-start guides
        Document any changes to APIs or behaviors

Contributing to Documentation

When adding or updating documentation:

    Follow the established directory structure
    Use Markdown formatting consistently
    Link related documents where appropriate
    Keep API documentation synchronized with code changes
    Update the relevant README files when adding new documents


---
# Sources
- [Style Guide](google.github.io/styleguide/cppguide.html)
- [A Simple C++ Project Structure](https://hiltmon.com/blog/2013/07/03/a-simple-c-plus-plus-project-structure/)
- [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
- [SemVer](https://semver.org/)
