# pros-zig-template
> A simple [PROS](https://github.com/purduesigbots/pros) template that adds support for compiling ZIG for the Vex V5 Brain.

# How to Use
---
## Prerequisits
- `pros-cli`
- `wget`
- `gnu-make`
- an `arm-none-eabi-gcc` toolchain
- `zig`
## Steps
1. Create a project with `PROS` conductor
  ```sh
  pros conduct create-project . V5
  ```
2. Download the template
  ```sh
  wget https://github.com/kalscium/pros-zig-template/releases/download/v1.1.2/pros-zig-template@1.1.1.zip
  ```
3. Fetch the template
  ```sh
  pros conduct fetch pros-zig-template@1.1.1.zip
  ```
5. Apply the template
  ```sh
  pros apply pros-zig-template
  ```
6. Modify the makefile
  - In the `Makefile` file, at the very bottom, there should be a line
    with the contents `-include common.mk`
  - Create a new line above that with the contents `-include zig.mk`
7. Clean up
  ```sh
  rm pros-zig-template@1.1.1.zip
  ```
8. Test that everything's working properly
  ```sh
  make
  ```
9. Enjoy
