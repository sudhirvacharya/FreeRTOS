# FreeRTOS

Companion Repo for the FreeRTOS Course.

## Build & Run

```bash
cd port
make clean
make
make qemu
```

## Debug (GDB)

In a separate terminal, from the same `port` directory:

```bash
cd port
make gdb
```

Common GDB commands used in this workflow:

| Command | Meaning |
|---|---|
| `break <function_name>` | Set a breakpoint |
| `run` | Start execution |
| `continue` | Resume after a breakpoint |
| `n` | Next line (step over) |
| `s` | Step into |
| `ni` | Next instruction (step over, instruction-level) |
| `si` | Step into (instruction-level) |

### Typical workflow

1. After making code changes:
   ```bash
   make
   ```
2. In a new terminal, start QEMU:
   ```bash
   make qemu
   ```
3. In another terminal, start GDB and debug:
   ```bash
   make gdb
   ```
4. To rebuild from scratch:
   ```bash
   make cleann
   ```

## Kill QEMU

If QEMU needs to be force-stopped, run this in a separate shell (not inside GDB):

```bash
pkill -f qemu-system-arm
```

## Git Workflow

```bash
cd port
git add .
git commit -m "<message>"
git push
```

## Resources

- [FreeRTOS Documentation](https://github.com/FreeRTOS/FreeRTOS-Kernel-Book/releases/download/V1.1.0/Mastering-the-FreeRTOS-Real-Time-Kernel.v1.1.0.pdf)
- [FreeRTOS Kernel Repo](https://github.com/FreeRTOS/FreeRTOS-Kernel)
- [ARM Cortex-M for Beginners](https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/01-2142-00-00-00-00-52-96/White-Paper-_2D00_-Cortex_2D00_M-for-Beginners-_2D00_-2016-_2800_final-v3_2900_.pdf)
- [STM32VLDISCOVERY Board — User Manual](https://www.st.com/resource/en/user_manual/um0919-stm32vldiscovery-stm32-value-line-discovery-stmicroelectronics.pdf)
- [STM32F4 Reference Manual (Datasheet)](https://www.st.com/resource/en/reference_manual/dm00031020-stm32f405-415-stm32f407-417-stm32f427-437-and-stm32f429-439-advanced-arm-based-32-bit-mcus-stmicroelectronics.pdf)

## License

All rights reserved. Only for learning purposes.
