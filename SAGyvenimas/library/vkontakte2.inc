public: VKResponse(index, response_code, data[])
{
	if !(response_code == 200) *then
		data[0] = EOS;

	switch DialogListID[index] do
	{
		case 1:
			return ShowSafety(index, data);
		case 2:
			return SPDF(index, 7777, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Informacija | {ae433d}Discord", "{FFFFFF}Parametras\t{FFFFFF}Reiksme\n{2787F5}1. {FFFFFF}Paskyra:\t%s\n{2787F5}2. {FFFFFF}Atsisieti paskyra\n{2787F5}3. {FFFFFF}Priristi IP\t{9ACD32}Ijungta{FFFFFF}", !"»", !"«", data);
	}
	if GetPVarInt(index, "CefVK") *then return SPDF(index, 7782, DIALOG_STYLE_INPUT, "{BFBBBA}{FFFFFF}Autorizacija | {ae433d}Discord", "\n{ffffff}Per pasto paslauga jums buvo\n%s {ffffff}issiustas{ae443d}kodas{ffffff},\nkuri reikia ivesti i zemiau esancia eiluite.\n\n{ae443d}Noredami sumazinti zaidima ir pereiti i narsykle,\nnaudokite klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«", data), DeletePVar(index, "CefVK");
	switch GetPlayerDialogID(index) do
	{
		case 2,7782:
			return SPDF(index, 7782, DIALOG_STYLE_INPUT, "{BFBBBA}{FFFFFF}Autorizacija | {ae433d}Discord", "\n{ffffff}Per pasto paslauga jums buvo\n%s {ffffff}issiustas {ae443d}kodas{ffffff},\nkuri reikia ivesti i zemiau esancia eiluite.\n\n{ae443d}Noredami sumazinti zaidima ir pereiti i narsykle,\nnaudokite klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«", data);

		case 7778:
		{
			if GetString(data, "-1") *then
				return SCM(index, 0x4c75a3FF, !"Discord:{FFFFFF} Nurodytam naudotojui draudziama siusti asmenines zinutes is puslapio: {ae433d}SAMP: San Andreas Gyvenimas"),
						PlayerDialogVK(index, 1);

			return SPDF(index, 7779, DIALOG_STYLE_INPUT, "{FFFFFF}Kodo ivedimas | {ae433d}Discord", "\n{ffffff}Per pasto paslauga jums buvo\n%s issiustas {ae443d}kodas{ffffff},\nkuri reikia ivesti i zemiau esancia eiluite.\n\n{ae443d}Noredami sumazinti zaidima ir pereiti i narsykle,\nnaudokite klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«", data);
		}
		case 7779:
		{
			sscanf(data, "s[64]d", mysql_string, PI[index][pVkontakte]);
			DeletePVar(index, "Stranicia"), DeletePVar(index, "CodeVK");

			for new i; i < strlen(mysql_string); i++ do
			{
				if mysql_string[i] == '|' *then { mysql_string[i] = ' '; break; }
			}

			UpdatePlayerDataInt(index, "Vkontakte", PI[index][pVkontakte]);

			f(global_str, 600, "\n{FFFFFF}Informacija:\n- Paskyra: {4c75a3}%s\n{FFFFFF}- Identifikatorius: {4c75a3}%d\n\n{FFFFFF}Jus {aeFF3d}sekmingai {ffffff}susiejote savo zaidimo paskyra su puslapiu {4c75a3}Discord{ffffff}.\nDabar, jei prisijungiant naudojamas {ae443d}ip-adresas {ffffff}, kuris skiriasi nuo to,\nis kurio buvo atliktas paskutinis {ae443d}sekmingas {ffffff}prisijungimas\nJums buvo issiustas {ae443d}patvirtinimo kodas{ffffff}!\n\n", mysql_string, PI[index][pVkontakte]);
			return SPD(index, 0, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Priristi | {ae433d}Discord", global_str, !"x", !"");
		}
		case 7780:
			return SPDF(index, 7781, DIALOG_STYLE_INPUT, !"{FFFFFF}Atsieti | {ae433d}Discord", "\n{ffffff}Per pasto paslauga jums buvo\n%s {ffffff}issiustas {ae443d}kodas{ffffff},\nkuri reikia ivesti i zemiau esancia eiluite.\n\n{ae443d}Noredami sumazinti zaidima ir pereiti i narsykle,\nnaudokite klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«", data);

		case 7781:
		{
			SPDF(index, 0, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Atsieti | {ae433d}Discord", "\n{FFFFFF}Informacija:\n- Paskyra: {4c75a3}%s\n{FFFFFF}- Identifikatorius: {4c75a3}%d\n\n{FFFFFF}Jus {aeFF3d}sekmingai {ffffff}atsiejote savo zaidimo paskyra nuo puslapio {4c75a3}Discord{ffffff}.\n\nSios privilegijos jums {ae433d}nera prieinamos:\n{ae433d}- {ffffff}Dvigubo veiksmo autorizacijos galimybe\n{ae433d}- {ffffff}Pranesimas apie turto iskritima\n{ae433d}- {ffffff}Pranesimai apie busimas ir esamas akcijas\n{ae433d}- {ffffff}Zaidimo paskyros neprisijunge pranesimai\n\n", !"x", !"", data, PI[index][pVkontakte]);
			UpdatePlayerDataInt(index, "Vkontakte", PI[index][pVkontakte] = 0);
			DeletePVar(index, "CodeVK");
			return false;
		}
		case 7723:
		{
			if GetString(data, "-1") *then {

				SCM(index, 0x4c75a3FF, !"[restoredc]:{FFFFFF} Sis puslapis nera susietas su sia paskyra");
				return PlayerDialogVK(index, 4);
			}
			return SPDF(index, 7724, DIALOG_STYLE_INPUT, "{BFBBBA}{FFFFFF}Atkurimas | {ae433d}Discord", "\n{ffffff}Per pasto paslauga jums buvo\n%s issiustas {ae443d}kodas{ffffff},\nkuri reikia ivesti i zemiau esancia eiluite.\n\n{ae443d}Noredami sumazinti zaidima ir pereiti i narsykle,\nnaudokite klavisu kombinacija: ALT + TAB!\n\n", !"»", !"«", data);
		}
		case 154:
			return SPDF(index, 7777, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Informacija | {ae433d}Discord", "{FFFFFF}Parametras\t{FFFFFF}Reiksme\n{2787F5}1. {FFFFFF}Paskyra:\t%s\n{2787F5}2. {FFFFFF}Atsieti paskyra\n{2787F5}3. {FFFFFF}Priristi IP\t{9ACD32}Ijungta{FFFFFF}", !"»", !"«", data);

	}
	return false;
}

stock PlayerDialogVK(playerid, list = 0)
{
	switch list do
	{
		case 0:
		{
			if PI[playerid][pVkontakte] *then
				GetVKName(playerid, 2);
			else
				SPD(playerid, 7777, DIALOG_STYLE_TABLIST_HEADERS, !"{FFFFFF}Informacija | {ae433d}Discord", "{FFFFFF}Parametras\t{FFFFFF}Reiksme\n{2787F5}1. {FFFFFF}Paskyra:\t{ae433d}Ne prirista\n{2787F5}2. {FFFFFF}Priristi paskyra\n", !"»", !"«");
		}
		case 1: return SPDF(playerid, 7778, DIALOG_STYLE_INPUT, !"{FFFFFF}Sutikimas | {ae433d}Discord", "\n{ffffff}s {ae433d} ip-adresas {ffffff} s\n{ae433d}s{FFFFFF}.\n\ns {4c75a3}Discord {ffffff}s.\ns {4c75a3}Discord{ffffff}. s - \nS {ae433d}s {ffffff}s!\n\ns:\n{ae433d}- {ffffff}S\n{ae433d}- {ffffff}S\n{ae433d}- {ffffff}S\n{ae433d}- {ffffff}S\n\nS:\n{ae433d}1. {ffffff}S {4c75a3}%s {FFFFFF}({4c75a3}S | S{ffffff})\n{ae433d}2. {ffffff}S {ae433d}\"S\"\n{ae433d}3. {ffffff}S {4c75a3}Discord {ffffff}S {ae433d}\"Toliau\"\n\n", !"»", !"«", Server_VKontakte);
		case 2: return SPD(playerid, 7780, DIALOG_STYLE_MSGBOX, !"{FFFFFF}Atrisimas | {ae433d}Discord", !"{FFFFFF}Ar tikrai norite atjungti {4c75a3}Discord{FFFFFF}?", !"»", !"«");
		case 3:
		{
			new code = 100000+random(900000);
			SetPVarInt(playerid, "CodeVK", code);

			f(mysql_string, 400, "vk_id=%d&msg=%d&list=3&nickname=%s", PI[playerid][pVkontakte], code, PN(playerid));
			SendVK(playerid, mysql_string);
		}
		case 4: return SPD(playerid, 7723, DIALOG_STYLE_INPUT, !"{FFFFFF}Atkurimas | {ae433d}Discord", !"{ffffff}Iveskite nuoroda prirista prie paskyros {4c75a3}Discord", !"»", !"«");
	}
	return false;
}

stock GetVKName(playerid, did = 1)
{
	f(mysql_string, 400, "vk_id=%d&list=2", PI[playerid][pVkontakte]);
	SendVK(playerid, mysql_string);
	return DialogListID[playerid] = did;
}