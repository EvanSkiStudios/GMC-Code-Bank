if (environment_get_variable("PROCESSOR_ARCHITECTURE") == "AMD64") { /* external_* 64-bit dll */ }
else if (environment_get_variable("PROCESSOR_ARCHITECTURE") == "x86") { /* external_* 32-bit dll */ }