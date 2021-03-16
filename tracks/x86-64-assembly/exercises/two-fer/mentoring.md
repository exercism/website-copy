# Mentoring

### Reasonable solutions

#### Hand-rolled loop

```nasm
    movzx edx, byte [rdi]
    test dl, dl
    je .loop_end
.loop_start:
    add rdi, 1
    mov byte [rsi], dl
    add rsi, 1
    movzx edx, byte [rdi]
    test dl, dl
    jne .loop_start
.loop_end:
```

#### Using `rep movsb` instructions

```nasm
    mov rdi, rsi
    lea rsi, [rel symbol]
    mov rcx, symbol_len
    rep movsb
```

#### Using the C standard library

```nasm
    mov rdx, rdi
    xor eax, eax
    mov rdi, rsi
    lea rsi, [rel format]
    call sprintf wrt ..plt
```

### Common errors

- Forgetting to save registers.

    > Registers `%rbp`, `%rbx` and `%r12` through `%r15` “belong” to the calling function and the called function is required to preserve their values. In other words, a called function must preserve these registers’ values for its caller. (Matz, Hubička, Jaeger, & Mitchell, 2014, p. 15)

    Depending on which registers the caller is using, the tests might still pass.

- Forgetting return.

    > A function declaration must end with . . . `RET`. . . . The execution will continue in the code after the procedure if there is no `RET`. (Fog, 2019, p. 10)

- Forgetting stack alignment.

    > The stack pointer must point to an address divisible by 16 before any call statement (Fog, 2019, p. 10)

### Common suggestions

- If they have code duplication, suggest to move the duplicate code into its own function or macro. For information on how to define a macro, see [https://www.nasm.us/xdoc/2.14.02/html/nasmdoc4.html#section-4.3](https://www.nasm.us/xdoc/2.14.02/html/nasmdoc4.html#section-4.3).

- Prefer registers over memory for saving values (Ash, 2013).

- If they are using the data segment (`.data`) for constants, suggest to use the read-only data segment (`.rodata`).

- Prefer `lea rax, [rel symbol]` over `mov rax, symbol`.

    > There is absolutely no reason to use absolute addresses for simple memory operands. Rip-relative addresses make instructions shorter, they eliminate the need for relocation at load time, and they are safe to use in all systems. (Fog, 2019, p. 21)

- Clearing the direction flag using `cld` is redundant.

    > The direction flag `DF` in the `%rFLAGS` register must be clear (set to “forward” direction) on function entry and return. (Matz, Hubička, Jaeger, & Mitchell, 2014, p. 15)

- Minimize loop overhead. Example:

  ```nasm
  .loop_start:
      movzx edx, byte [rdi]
      test dl, dl
      je .loop_end
      add rdi, 1
      mov byte [rsi], dl
      add rsi, 1
      movzx edx, byte [rdi]
      test dl, dl
      jmp .loop_start
  .loop_end:
  ```

    > The most important problem with the loop . . . is that there are two jump instructions. We can eliminate one jump from the loop by putting the branch instruction in the end: (Fog, 2019, p. 89)

  ```nasm
      movzx edx, byte [rdi]
      test dl, dl
      je .loop_end
  .loop_start:
      add rdi, 1
      mov byte [rsi], dl
      add rsi, 1
      movzx edx, byte [rdi]
      test dl, dl
      jne .loop_start
  .loop_end:
  ```

### Optimizations

- Prefer `movzx edx, byte [rdi]` over `mov dl, byte [rdi]`.

    > Prevent false dependences by writing to a full register rather than a partial register. (Fog, 2019, p. 61-62)

- Prefer `add/sub` over `inc/dec`.

    > The `INC` and `DEC` instructions are inefficient on some CPUs because they write to only part of the flags register (excluding the carry flag). Use `ADD` or `SUB` instead to avoid false dependences or inefficient splitting of the flags register. (Fog, 2019, p. 62)

- Prefer `test dl, dl` over `cmp dl, 0` to reduce the size of the code.

- Make conditional jumps most often not taken.

    > The efficiency and throughput for not-taken branches is better than for taken branches on most processors. Therefore, it is good to place the most frequent branch first (Fog, 2019, p. 68)

- Eliminating calls.

    > It is possible to replace a call followed by a return by a jump (Fog, 2019, p. 68)

### References

Ash, M. (2013). _Friday Q&A 2013-10-11: Why Registers Are Fast and RAM Is Slow_. Retrieved from [https://www.mikeash.com/pyblog/friday-qa-2013-10-11-why-registers-are-fast-and-ram-is-slow.html](https://www.mikeash.com/pyblog/friday-qa-2013-10-11-why-registers-are-fast-and-ram-is-slow.html)

Fog, A. (2019). _Optimizing subroutines in assembly language. An optimization guide for x86 platforms_. Retrieved from [https://www.agner.org/optimize/optimizing_assembly.pdf](https://www.agner.org/optimize/optimizing_assembly.pdf)

Matz, M., Hubička, J., Jaeger, A., & Mitchell, M. (2014). _System V Application Binary Interface AMD64 Architecture Processor Supplement_. Retrieved from [https://www.uclibc.org/docs/psABI-x86_64.pdf](https://www.uclibc.org/docs/psABI-x86_64.pdf)
