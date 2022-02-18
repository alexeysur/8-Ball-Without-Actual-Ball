# 8-Ball-Without-Actual-Ball
![Platforms](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Description:
Application to get answer on any question user asks :)<br>
Shake phone and application will give random answer using API request. If there is internet connection issue you will receive one of the hardcoded answers.

## Requirement:
Application gets random answers from endpoint https://8ball.delegator.com/magic/JSON/<question_string>. <br>
You are free to use any string as parameter (no need to send actual question) <br>
In case of internet connection absence or request failure, application uses one of hardcoded answers <br>
Application should have two screens: Main and Settings <br>
Main screen contains call-to-shake text or answer, depending on the current application state. <br>
Settings screen allows the user to set and save hardcoded answers like ""Just do it!"", ""Change your mind"", etc.

## Author
Alexey Sur - alexeysur@gmail.com
