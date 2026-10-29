
public: fortunetimer()//fortune
{
	if(fortunestep > 0)
	{
	    FortuneMove();
		fortunestep--;
	}
	else
	{
	    SetCameraBehindPlayer(fortunestarter);
		TogglePlayerControllable(fortunestarter, true);
  		new b = Rand(1, 10);
		switch(random(101))
		{
		    case 0..14: AddItem(fortunestarter, 531, 20), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote Desert Eagle 20");
		    case 15..16: GiveDonate(fortunestarter, b), SCMF(fortunestarter, 0xAFAFAFFF, "Jus gavote SAG Coins %d", b);
		    case 17..30: AddItem(fortunestarter, 591, 10), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote EXP 10");
			case 31..40: AddItem(fortunestarter, 1461, 1), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote 1 BTC!");
			case 41..50: AddItem(fortunestarter, 324, 1), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote bronzine rulete 1");
			case 51..60: AddItem(fortunestarter, 323, 1), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote sidabrine rulete 1");
			case 61..70: AddItem(fortunestarter, 322, 1), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote auksine rulete 1");
			case 71..97: AddItem(fortunestarter, 365, 30), SCM(fortunestarter, 0xAFAFAFFF, "Jus gavote seimos talonus 30");
			case 98..100:
			{
       			AddItem(fortunestarter, 14195, 1);
       			SCM(fortunestarter, 0xAFAFAFFF, "SVEIKINAME! Jus gavote GERIAUSIA priza: Ford Mustang Razor");
				SCMALLF(0xFF6347FF, "[Geriausias prizas Laimes rato] DEMESIO! %s Laimejo geriausia priza: Ford Mustang Razor", PN(fortunestarter));
			}
		}
		fortunestarter = -1;
	    KillTimer(fortunespeed);
	}
}
	
stock FortuneMove()
{
    new Float:x, Float:y, Float:z, Float:Rx, Float:Ry, Float:Rz;
	GetObjectPos(fortune, x, y, z);
	GetObjectRot(fortune, Rx, Ry, Rz);
    Ry += 18.0;
    if(Ry >= 360.0) Ry = 0.0;
    MoveObject(fortune, x, y, z, 0.5, Rx, Ry, Rz);
}
stock Rand(min, max)
{
	new a = random(max - min) + min;
	return a;
}
