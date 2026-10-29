CMD:transfer(playerid)
{
    if !PI[playerid][pVkontakte] *then
		return SCM(playerid, COLOR_OLDRED, !"[Klaida] {FFFFFF}Norint pervesti savo paskyra, turite prijungti Discord - [/settings - Priristi Discord]");

	f(global_str, sizeof(global_str), "{cccccc}Informacija | {ae433d}%s", PN(playerid));

	if !TranslationValidation(playerid) *then
		SPD(playerid, 18704, DIALOG_STYLE_LIST, global_str, !"{ae433d}— {FFFFFF}Pereiti prie paskyros vertimo pateikimo.\n{ae433d}— {FFFFFF}Informacija apie pervedima.", !"»", !"x");

	else 
		SPD(playerid, 18704, DIALOG_STYLE_LIST, global_str, !"{ae433d}— {FFFFFF}Informacija apie irasyta pervedima.\n{ae433d}— {FFFFFF}Informacija apie pervedima.", !"»", !"x");

	return true;
}

stock ShowTransferDialog(playerid, transfering = 0)
{
	switch(Transfer[playerid][PerevodDialog])
	{
	    case 0: SPD(playerid, 18705, DIALOG_STYLE_LIST, !"{cccccc}Duomenu registracija | {ae433d}Serverio pasirinkimas", !"{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG\n{FFFFFF}San Andreas Gyvenimas {ae433d}SAG", !"Toliau", !"Atsaukti");
		case 1:
		{
			if(!transfering) SPDF(playerid, 18705, DIALOG_STYLE_INPUT, "{cccccc}Duomenu registracija | {ae433d}Paskyros pervedimas", "{FFFFFF}Iveskite zaidimo duomenis {ae433d}%s {FFFFFF}pagal toliau pateikta instrukcija.\n{ae433d}Uzuomina: {FFFFFF}Jusu Nick ir slaptazodis (Yevhen_Kosovskyi | N99h67Pgcr9DRooD)\n{FFFFFF}Ivede duomenis sekmingai, paspauskite \"Toliau\"", !"Toliau", !"Atgal", Transfer[playerid][PerevodServer]);
			else SPDF(playerid, 18705, DIALOG_STYLE_INPUT, "{cccccc}Duomenu registracija | {ae433d}Paskyros pervedimas", "{FFFFFF}Iveskite zaidimo duomenis {ae433d}%s {FFFFFF}pagal toliau pateikta instrukcija.\n{ae433d}Uzuomina: {FFFFFF}Jusu Nick ir slaptazodis (Yevhen_Kosovskyi | N99h67Pgcr9DRooD)\n{FFFFFF}Ivede duomenis sekmingai, paspauskite \"Toliau\"", !"Toliau", !"Atgal", Transfer[playerid][PerevodServer]);
		}
		case 2:
		{
		    SAMF(COLOR_OLDRED, "[Ispejimas] {FFFFFF}Zaidejas kito serverio %s(%d) uzregistravo nauja rasyma del pervedimo i kita serveri.", PN(playerid), playerid);
			SPDF(playerid, 0, 0, !"{cccccc}Informacija | {ae433d}Pervedimo pabaiga", "{ae433d}%s {FFFFFF}jusu prasymas pervesti saskaita sekmingai issiustas\nserverio vadovu perziurai, tai gali trukti iki 48 darbo valandu.\n\nPapildoma informacija:\n\
			{FFFFFF}Serveris, is kurio norite perkelti saskaita: {ae433d}%s.\n\
			{FFFFFF}Jusu Nick  serveryje, is kurio perkeliate saskaita: {ae433d}%s.\n\
			{FFFFFF}Paskyros slaptazodis: {ae433d}%s.", !"Uzdaryti", !"", PN(playerid), Transfer[playerid][PerevodServer], Transfer[playerid][PerevodNick], Transfer[playerid][PerevodPassword]);
			SQL("INSERT INTO `transfer` (`NickName`, `PerevodNick`, `PerevodPassword`, `PerevodServer`, `Status`) VALUES ('%s', '%s', '%s', '%s', '0');", PN(playerid), Transfer[playerid][PerevodNick], Transfer[playerid][PerevodPassword], Transfer[playerid][PerevodServer]);
		}
	}
	return 1;
}

stock TranslationValidation(playerid)
{
    new
		validation = cache_num_rows();

    f(mysql_string, 128, "SELECT `NickName` FROM `Transfer` WHERE `NickName` = '%s' LIMIT 1", PN(playerid));
    mysql_query(mysql, mysql_string);

	return validation;
}
