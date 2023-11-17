#macro BEGIN_ASSERT if (debug_mode || os_get_config() == "debug") && !(
#macro END_ASSERT ) show_error("Assertion failed", true)

// Example:
BEGIN_ASSERT something() END_ASSERT