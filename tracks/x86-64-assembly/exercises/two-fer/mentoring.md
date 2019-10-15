### Reasonable solutions

Using a hand-rolled loop:

```nasm
    movzx edx, byte [rdi]
    test dl, dl
    je .L2
.L1:
    add rdi, 1
    mov byte [rsi], dl
    add rsi, 1
    movzx edx, byte [rdi]
    test dl, dl
    jne .L1
.L2:
```

Using the `rep movsb` instructions:

```nasm
    mov rdi, rsi
    lea rsi, [rel symbol]
    mov rcx, symbol_len
    rep movsb
```

### Common errors

- Forgetting to save registers with callee-save status (`rbx`, `rbp`, `r12-r15`).
- Forgetting return. A function declaration must end with `ret`.

### Common suggestions

- Move the string copy code into its own function or macro to avoid code duplication.

- Use registers instead of memory for saving values as they are faster.

- Prefer `lea rax, [rel symbol]` to `mov rax, symbol`.

    > There is absolutely no reason to use absolute addresses for simple memory operands. Rip-relative addresses make instructions shorter, they eliminate the need for relocation at load time, and they are safe to use in all systems. ([https://www.agner.org/optimize/optimizing_assembly.pdf](https://www.agner.org/optimize/optimizing_assembly.pdf), p. 21)

- Clearing the direction flag using `cld` is redundant.

    > The direction flag `DF` in the `%rFLAGS` register must be clear (set to “forward” direction) on function entry and return. ([https://www.uclibc.org/docs/psABI-x86_64.pdf](https://www.uclibc.org/docs/psABI-x86_64.pdf), p. 15)

- Minimize loop overhead. Example:

    ```nasm
    .L1:
        movzx edx, byte [rdi]
        test dl, dl
        je .L2
        add rdi, 1
        mov byte [rsi], dl
        add rsi, 1
        movzx edx, byte [rdi]
        test dl, dl
        jmp .L1
    .L2:
    ```

    We can eliminate the unconditional jump from the loop by putting the branch instruction in the end:

    ```nasm
        movzx edx, byte [rdi]
        test dl, dl
        je .L2
    .L1:
        add rdi, 1
        mov byte [rsi], dl
        add rsi, 1
        movzx edx, byte [rdi]
        test dl, dl
        jne .L1
    .L2:
    ```

### Optimizations

- Prefer `movzx edx, byte [rdi]` to `mov dl, byte [rdi]`.

    > Prevent false dependences by writing to a full register rather than a partial register. ([https://www.agner.org/optimize/optimizing_assembly.pdf](https://www.agner.org/optimize/optimizing_assembly.pdf), p. 62)

- Prefer `add/sub` to `inc/dec`.

    > The INC and DEC instructions are inefficient on some CPUs because they write to only part of the flags register (excluding the carry flag). Use ADD or SUB instead to 63 avoid false dependences or inefficient splitting of the flags register. ([https://www.agner.org/optimize/optimizing_assembly.pdf](https://www.agner.org/optimize/optimizing_assembly.pdf), p. 62)

- Prefer `test dl, dl` to `cmp dl, 0` to reduce the size of the code.

- Make conditional jumps most often not taken.

    > The efficiency and throughput for not-taken branches is better than for taken branches on most processors. Therefore, it is good to place the most frequent branch first: ([https://www.agner.org/optimize/optimizing_assembly.pdf](https://www.agner.org/optimize/optimizing_assembly.pdf), p. 68)
