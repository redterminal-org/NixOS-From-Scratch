use std::{thread, time::Duration};

unsafe extern "C" {
    fn arduino_bridge_setup();
    fn arduino_bridge_loop();
}

fn main() {
    esp_idf_sys::link_patches();

    unsafe {
        arduino_bridge_setup();
    }

    loop {
        unsafe {
            arduino_bridge_loop();
        }
        thread::sleep(Duration::from_millis(10));
    }
}
