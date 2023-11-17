function datetime_current_string(){
	var tz = date_get_timezone();
	date_set_timezone(timezone_utc);
	var out = string_format(current_year, 4, 0) + string_format(current_month, 2, 0) + string_format(current_day, 2, 0) + "T" + string(current_hour) + ":" + string(current_minute) + ":" + string(current_second) + "Z";
	date_set_timezone(tz);
	return out;
}
