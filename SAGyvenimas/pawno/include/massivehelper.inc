                                                                                                                                        
/*
// ILYA SYSTEM 
new SQL_STRING[1250];
#define str_f(%0,%1) format(SQL_STRING, sizeof SQL_STRING, %0, %1), SQL_STRING
*/

new
	RETURN_STRING[10][2048],
	RETURN_STRING_FIXTEXT[128],
	sql_get[144][144];

stock String_UnPackMassive(Pack_Data[], UnPack_Data[][], unpack_format[] = "s[128]", unpack_separation[] = ",", len = sizeof UnPack_Data, data = 0) 
{
	sscanf(Pack_Data, (str_f("p<%s>a<%s>[%d]", unpack_separation, unpack_format, len)), data ? sql_get : SQL_GET_ROW_STR);
	
	for new i; i < len; i++ do
		SetString(UnPack_Data[i], data ? sql_get[i] : SQL_GET_ROW_STR[i]);

	return true;
}

stock Int_UnPackMassive(Pack_Data[], UnPack_Data[], unpack_format[] = "i", unpack_separation[] = ",", len = sizeof UnPack_Data)
	return (sscanf(Pack_Data, (str_f("p<%s>a<%s>[%d]", unpack_separation, unpack_format, len)), UnPack_Data));

stock Int_PackMassive_return(num = 0, Data[], len = sizeof Data)
{
	RETURN_STRING[num][0] = EOS;
	
	for new i; i < len; i++ do
	{
		strcat(RETURN_STRING[num], ( str_f("%d,", Data[i]) ) );
	}
}

#define Int_PackMassive(%0,%1) (Int_PackMassive_return(%0, %1), RETURN_STRING[%0])

stock Float_UnPackMassive(Pack_Data[], Float:UnPack_Data[], unpack_format[] = "f", unpack_separation[] = ",", len = sizeof UnPack_Data)
	return (sscanf(Pack_Data, (str_f("p<%s>a<%s>[%d]", unpack_separation, unpack_format, len)), UnPack_Data));
	
stock Float_PackMassive_return(num = 0, Float:Data[], len = sizeof Data)
{
	RETURN_STRING[num][0] = EOS;
	
	for new i; i < len; i++ do
	{
		strcat(RETURN_STRING[num], ( str_f("%f,", Data[i]) ) );
	}
}

#define Float_PackMassive(%0,%1) (Float_PackMassive_return(%0, %1), RETURN_STRING[%0])

stock String_PackMassive_return(num = 0, Data[][], len = sizeof Data)
{
	RETURN_STRING[num][0] = EOS;
	
	for new i; i < len; i++ do
	{
		strcat(RETURN_STRING[num], ( str_f("%s%s", Data[i], (len-1) == i ? "":",") ) );
	}                                                                                                                                                                          
}

#define String_PackMassive(%0,%1) (String_PackMassive_return(%0, %1), RETURN_STRING[%0])


#define FixText(%0) (FixText_function(%0), RETURN_STRING_FIXTEXT)

stock FixText_function(const string[])
{
	for new i; i < strlen(string); i++ do
	{
		switch string[i] do
		{ 
			case 'à': RETURN_STRING_FIXTEXT[i] = 'a';  
			case 'À': RETURN_STRING_FIXTEXT[i] = 'A';  
			case 'á': RETURN_STRING_FIXTEXT[i] = '—';  
			case 'Á': RETURN_STRING_FIXTEXT[i] = '€';  
			case 'â': RETURN_STRING_FIXTEXT[i] = '¢';  
			case 'Â': RETURN_STRING_FIXTEXT[i] = '‹';  
			case 'ã': RETURN_STRING_FIXTEXT[i] = '™';  
			case 'Ã': RETURN_STRING_FIXTEXT[i] = '‚';  
			case 'ä': RETURN_STRING_FIXTEXT[i] = 'š';  
			case 'Ä': RETURN_STRING_FIXTEXT[i] = 'ƒ';  
			case 'å': RETURN_STRING_FIXTEXT[i] = 'e';  
			case 'Å': RETURN_STRING_FIXTEXT[i] = 'E';  
			case '¸': RETURN_STRING_FIXTEXT[i] = 'e';  
			case '¨': RETURN_STRING_FIXTEXT[i] = 'E';  
			case 'æ': RETURN_STRING_FIXTEXT[i] = '›';  
			case 'Æ': RETURN_STRING_FIXTEXT[i] = '„';  
			case 'ç': RETURN_STRING_FIXTEXT[i] = 'Ÿ';  
			case 'Ç': RETURN_STRING_FIXTEXT[i] = 'ˆ';  
			case 'è': RETURN_STRING_FIXTEXT[i] = 'œ';  
			case 'È': RETURN_STRING_FIXTEXT[i] = '…';  
			case 'é': RETURN_STRING_FIXTEXT[i] = 'œ';  
			case 'É': RETURN_STRING_FIXTEXT[i] = '…';  
			case 'ê': RETURN_STRING_FIXTEXT[i] = 'k';  
			case 'Ê': RETURN_STRING_FIXTEXT[i] = 'K';  
			case 'ë': RETURN_STRING_FIXTEXT[i] = 'ž';  
			case 'Ë': RETURN_STRING_FIXTEXT[i] = '‡';  
			case 'ì': RETURN_STRING_FIXTEXT[i] = '¯';  
			case 'Ì': RETURN_STRING_FIXTEXT[i] = 'M';  
			case 'í': RETURN_STRING_FIXTEXT[i] = '®';  
			case 'Í': RETURN_STRING_FIXTEXT[i] = 'H'; 
			case 'î': RETURN_STRING_FIXTEXT[i] = 'o';  
			case 'Î': RETURN_STRING_FIXTEXT[i] = 'O';  
			case 'ï': RETURN_STRING_FIXTEXT[i] = '£';  
			case 'Ï': RETURN_STRING_FIXTEXT[i] = 'Œ';  
			case 'ð': RETURN_STRING_FIXTEXT[i] = 'p';  
			case 'Ð': RETURN_STRING_FIXTEXT[i] = 'P';  
			case 'ñ': RETURN_STRING_FIXTEXT[i] = 'c';  
			case 'Ñ': RETURN_STRING_FIXTEXT[i] = 'C';  
			case 'ò': RETURN_STRING_FIXTEXT[i] = '¦';  
			case 'Ò': RETURN_STRING_FIXTEXT[i] = '';  
			case 'ó': RETURN_STRING_FIXTEXT[i] = 'y';  
			case 'Ó': RETURN_STRING_FIXTEXT[i] = 'Y';   
			case 'ô','Ô': RETURN_STRING_FIXTEXT[i] = '';  
			case 'õ': RETURN_STRING_FIXTEXT[i] = 'x';  
			case 'Õ': RETURN_STRING_FIXTEXT[i] = 'X'; 
			case 'ö','Ö': RETURN_STRING_FIXTEXT[i] = '‰';  
			case '÷': RETURN_STRING_FIXTEXT[i] = '¤';  
			case '×': RETURN_STRING_FIXTEXT[i] = '';  
			case 'ø': RETURN_STRING_FIXTEXT[i] = '¥';  
			case 'Ø': RETURN_STRING_FIXTEXT[i] = 'Ž';  
			case 'ù': RETURN_STRING_FIXTEXT[i] = '¡';  
			case 'Ù': RETURN_STRING_FIXTEXT[i] = 'Š';  
			case 'ü': RETURN_STRING_FIXTEXT[i] = '©';  
			case 'Ü': RETURN_STRING_FIXTEXT[i] = '’';  
			case 'ú': RETURN_STRING_FIXTEXT[i] = '';  
			case 'Ú': RETURN_STRING_FIXTEXT[i] = '§';  
			case 'û': RETURN_STRING_FIXTEXT[i] = '¨';  
			case 'Û': RETURN_STRING_FIXTEXT[i] = '‘';  
			case 'ý': RETURN_STRING_FIXTEXT[i] = 'ª';  
			case 'Ý': RETURN_STRING_FIXTEXT[i] = '“';  
			case 'þ': RETURN_STRING_FIXTEXT[i] = '«';  
			case 'Þ': RETURN_STRING_FIXTEXT[i] = '”';  
			case 'ÿ': RETURN_STRING_FIXTEXT[i] = '¬';  
			case 'ß': RETURN_STRING_FIXTEXT[i] = '•';  
			default: RETURN_STRING_FIXTEXT[i] = string[i];
        }  
    }

	RETURN_STRING_FIXTEXT[strlen(string)] = '\0';
} 
