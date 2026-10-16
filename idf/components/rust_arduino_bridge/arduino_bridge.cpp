#include <Arduino.h>
#include "arduino_bridge.h"

extern "C" void arduino_bridge_setup(void) {
    initArduino();
    Serial.begin(115200);
    Serial.println("Rust + Arduino bridge started");
}

extern "C" void arduino_bridge_loop(void) {
    // Place Arduino library calls here or delegate to project-specific C++ code.
    delay(1);
}
