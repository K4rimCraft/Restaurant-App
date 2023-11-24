# SRC=main.c
# PROJECT_NAME=led_blink
# TARGET=main

# compile:$(SRC)
# 	@avr-gcc -mmcu=atmega32 -O0 -DF_CPU=8000000UL -o $(TARGET).elf $(SRC)
# 	@avr-objcopy -j .text -j .data -O ihex $(TARGET).elf $(PROJECT_NAME).hex
# 	@echo "Success Compiled"

# flash: compile
# 	@avrdude -c usbasp -p m32 -B 0.5 -U flash:w:"${PROJECT_NAME}.hex":a


# clean:
# 	@rm $(PROJECT_NAME).hex $(TARGET).o $(TARGET).elf
# 	@echo "Done"




FILENAME   = main
DEVICE     = atmega32
COMPILE    = avr-gcc -Wall -Os -mmcu=$(DEVICE)

compile:
	@$(COMPILE) -c $(FILENAME).c -o $(FILENAME).o
	@$(COMPILE) -o $(FILENAME).elf $(FILENAME).o 
	@avr-objcopy -j .text -j .data -O ihex $(FILENAME).elf $(FILENAME).hex 
	@avr-size --format=avr --mcu=$(DEVICE) $(FILENAME).elf
	@echo "Success Compiled"

flash: compile
	@avrdude -c usbasp -p m32 -B 0.5 -U flash:w:"${FILENAME}.hex":a

clean:
	@rm $(FILENAME).o
	@rm $(FILENAME).elf
	@rm $(FILENAME).hex
	@echo "Done"