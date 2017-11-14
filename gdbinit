# Connect to OpenOCD
target remote | openocd -f /home/cranc/Programs/Arm_stuff/FRDM-K64F-baremetal-minimal/board/frdm-k64f.cfg -c "gdb_port pipe; log_output openocd.log"
# Reset the target and call its init script
monitor reset init
# Halt the target. The init script should halt the target, but just in case
monitor halt
# pick file 
file ./main.elf
# Load it up
load
