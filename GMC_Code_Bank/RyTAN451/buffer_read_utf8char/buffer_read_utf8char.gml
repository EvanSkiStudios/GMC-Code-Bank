function buffer_read_utf8char(buffer) {
	var output = buffer_read(buffer, buffer_u8);
	if (output & 0x80 == 0)
		return output
	if (output & 0xF0 == 0xE0) {
		output = (output << 16) | buffer_read(buffer, buffer_u16);
		return output;
	} else {
		output = (output << 8) | buffer_read(buffer, buffer_u8);
		if (output & 0xE000 == 0xC000)
			return output;
		output = (output << 16) | buffer_read(buffer, buffer_u16);
		return output;
	}
}