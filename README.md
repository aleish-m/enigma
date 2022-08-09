# Enigma

## Learning Goals / Areas of Focus
- Practice breaking a program into logical components
- Build classes that demonstrate single responsibilities
- Test drive a well-designed Object Oriented solution
- Work with file i/o

## Overview
In this project, I used Ruby to build a tool for encrypting text and decrypting text using an encryption algorithm. I had to ensure I understood the Encryption Algorithm and plan out what classes and modules I needed to complete the project and keep it organized.

### File Structure 
- **Enigma**
: main class that the code base runs on for both `encrypt method` and `decrypt method`
- **Calculatable**
: module that hosuses the methods used for calculating the encryption algorithm.
- **Shiftable**
: module that hosuses the methods used for shifting the text recived in to the output text for both encrypt and decrypt options.
- **Readable**
: module used for reading/writing user input/output both on commandline and in `.txt` files.
- **Encrypt**
: runner file for `encrypt method` of enigma to run on command line.
- **Decrypt**
: runner file for `decrypt method` of enigma to run on command line.
- **Messge.txt**
: text file for text input that you would want to encrypt.
- **Encrypt.txt**
: text file for the encrypted text output for `encrypt` method or encrypted text input for `decrypt` method.
- **Decrypted.txt**
: text file for text output enigma has decrypted.
___

# Self Evaluation

## Functionality 
---
- [x] Enigma Class with `encrypt` and `decrypt` methods successfully implemented. Encrypt/decrypt command line interfaces successfully implemented
- I successfully implemented both the encrypt and decrypt methods and the command line interface.

## Object Oriented Programming
---
- [x] Students have implemented either inheritance or at least one module in a logical manner. Students can speak as to how/why inheritance and modules made sense for the given implementations, why they improved the organization of the code, and the distinction between the two.
- I used 3 modules to separate my code into logical sections. I tried to consider the purpose of each method and how it interacts with the whole. Doing this, I found there were sections that I could see being useful for other projects that might try to achieve something similar, and that is how I selected the use of modules rather than inheritance for my project.

- [x] Project is broken into logical components that are appropriately encapsulated.
- My `encrypt_index` and `dencrypt_index` methods call on a method in a different module for shifting the message and calculating the shift. But mostly, I could keep methods that worked together with each other and have them all talk to the `enigma` class to pass information as needed.

- [x] No classes are unreasonably small or large or contain knowledge/information/behavior they shouldn’t know about.
- I kept each class and module between 20- 60 lines of code, and the runners are about 10. This keeps them with a distinct purpose but not so long that they are hard to follow.

## Ruby Conventions and Mechanics
---
- [x] Classes, methods, and variables are well named so that they clearly communicate their purpose. 
- I named the classes and most methods clearly and consistently within the classes and modules. 
- I did go through and rename several methods to better clarify a few that initially were ambiguous or poorly named.

- [x] Code is all properly indented, and syntax is consistent. No methods are longer than 10 lines long. 
- My longest method is 12 lines of code. Including the `def` and `end`(Thank you, helper methods, and use of built-in enumerables/methods/keywords)
```
  .char
  .join
  .find_index
  variable arguments
  booleans
   ```

- [x] Most enumerables/data structures chosen are the most efficient tool for a given job, and students can speak as to why those enumerables/data structures were chosen.
- I used arrays for things like `message_array` and `create_shifted_message` , and hashes for `key_shift` and `total_shift_value`. I mostly used hashes to calculate my encryption algorithm and assign it to an `A, B, C, or D` shift. Then I used arrays for the input and output character sets to modify and reassemble them.

## Test Driven Development
___
- [x] Mocks and/or stubs are used appropriately to ensure two or more of the following: testing is more robust (i.e., testing methods that might not otherwise be tested due to factors like randomness or user input), testing is more efficient, or that classes can be tested without relying on functionality from other classes. Students are able to speak as to how mocks and/or stubs are fulfilling the above conditions.
- I used Subs to test that `date` and a random `key` were being provided if not given by the user. I also used stubs to test a few of my command line interface helper methods.

- [x] Test coverage metrics show 100% coverage.
- My simplecov coverage is 92% total due to 2 command line interface interaction methods that I am unable to test. All non-CLI methods are at 100% coverage.


## Version Control
___
- [x] Minimum 40 commits and 4 pull requests.
- I have 12 branches and 71 commits.

- [x] More than half of your pull requests include related and logical chunks of functionality, and are named and documented to clearly communicate the purpose of the pull request.
- I have several pull requests that did not stay separated from the rest on purpose, as I would realize I wanted to fix or change something and forget to change branches before I committed that change. I tried to become more aware of this as I worked on the project, but this is an area that I have room for improvement.

- [ ] No more than 3 commits include multiple pieces of functionality.
- I have not gone through and counted this, but I am pretty sure I have more than three where two or three changes are documented in the same commit.
