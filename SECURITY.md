# Security Policy

## Reporting a Vulnerability

We take security issues seriously and appreciate responsible disclosure.
**Please do not report security vulnerabilities through public GitHub issues.**

Instead, report them using one of the following private channels:

- **GitHub Private Vulnerability Reporting**: Go to the **Security** tab of this repository → **Report a vulnerability**.
- **Email**: security@example.com (replace with your project's actual security contact)

You should receive a response within **48 hours**. If for some reason you do not, please follow up via email to ensure we received your original message.

### What to Include

To help us triage and respond quickly, please include as much of the following as possible:

- **Type of vulnerability** (e.g. XSS, SQL injection, RCE, auth bypass, information disclosure)
- **Affected component(s)** and version(s) or commit hash
- **Steps to reproduce** the issue
- **Proof-of-concept code** or screenshots, if available
- **Impact** of the vulnerability (what an attacker could do)
- **Any suggested fix or mitigation**, if known

### Example Report Template

```
### Summary
A brief description of the vulnerability.

### Affected Version(s) / Commit
e.g. v2.1.0 or commit abc1234

### Vulnerability Type
e.g. Stored XSS

### Steps to Reproduce
1. ...
2. ...
3. ...

### Impact
What could an attacker achieve by exploiting this?

### Suggested Fix (optional)
...

### Reporter Information (optional)
Name / handle for credit in the security advisory, if desired.
```

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 2.x.x   | :white_check_mark: |
| 1.x.x   | :x:                |
| < 1.0   | :x:                |

<!-- Update this table to reflect your project's actual support policy -->

## Disclosure Policy

- We will confirm receipt of your report within 48 hours.
- We will investigate and provide an initial assessment within 5 business days.
- Once a fix is available, we will coordinate a disclosure timeline with the reporter.
- Credit will be given to the reporter in the security advisory, unless anonymity is requested.

## Scope

This policy applies to vulnerabilities found in this repository's code. Vulnerabilities in third-party dependencies should be reported to the respective maintainers, though we welcome a heads-up so we can track and update accordingly.
