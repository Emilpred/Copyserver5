/* Update Unix CONVERTOR BY VK.COM/CODER_SUPREME */

#define IsLeapYear(%1)     ((%1 % 4 == 0 && %1 % 100 != 0) || %1 % 400 == 0)

stock GetDaysInMonth(month, year)
{
    static MonthS[] = {
        31, // Enero
        28, // Febrero
        31, // Marzo
        30, // Abril
        31, // Mayo
        30, // Junio
        31, // Julio
        31, // Agosto
        30, // Septiembre
        31, // Octubre
        30, // Noviembre
        31  // Diciembre
    };
    return ((month >= 1 && month <= 12) ? (MonthS[month-1] + (IsLeapYear(year) && month == 2 ? 1 : 0)) : 0);
}

stock UNIX_TO_DATE(unix) 
{
	new string[17];

    new 
		year = 1970,
		day = 1,
		month = 1,
		hour = 3, 
		minuit;

    while unix >= 86400 do
	{
        unix -= 86400;

        day ++;
        if day > GetDaysInMonth(month, year) *then
		{
            day = 1;
            month ++;
            
			if month > 12 *then
			{
                year++;
                month = 1;
            }
        }
    }

	hour += unix / 3600;
	minuit = (unix - (hour -3 ) * 3600) / 60;

    if hour >= 24 *then
        hour -= 24, day++;

	format(string, sizeof string, "%02d:%02d %02d.%02d.%d", hour, minuit, day, month, year);
	return string;
}

stock UNIX_TO_MONTH(unix) 
{
	new string[17];

    new 
		day = 1;

    while unix >= 86400 do
	{
        unix -= 86400;

        day ++;
    }
	
	format(string, sizeof string, "%02d", day);
	return string;
}

stock UNIX_TO_TIME(data1, data2, data3 = 0)
{
	new hour, minuit, second, UNIX = gettime(hour, minuit, second);
	
	if data1 < hour *then
		data1 = 24 - (hour - data1),
		UNIX += (data1 * 3600 + data2 * 60 + data3) - ( minuit * 60 + second); 
	
	else
		UNIX += (data1 * 3600 + data2 * 60 + data3) - (hour * 3600 + minuit * 60 + second); 
	
	return UNIX;
}

/* Update Unix CONVERTOR BY VK.COM/CODER_SUPREME */