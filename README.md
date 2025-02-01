# pros-zig-template
> A simple [PROS](https://github.com/purduesigbots/pros) template that adds support for compiling ZIG for the Vex V5 Brain.

# How to Use
---
1. Create a project with `PROS` conductor
  ```sh
  pros conduct create-project . V5
  ```
2. Fetch the `pros-zig-template`
  ```sh
  pros conduct fetch https://github.com/kalscium/pros-zig-template/releases/download/1.0.0/pros-zig-template@1.0.0.zip
  ```
3. Apply the template
  ```sh
  pros apply pros-zig-template
  ```
4. Modify the makefile
  - In the `Makefile` file, at the very bottom, there should be a line
    with the contents `-include common.mk`
  - Create a new line above that with the contents `-include zig.mk`
