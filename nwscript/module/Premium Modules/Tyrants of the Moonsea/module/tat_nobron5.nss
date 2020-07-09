void main()
{
if (GetLocalInt(GetFirstPC(), "nobronfollow") == 1)

SpeakString("You cannot flee the area while the Bron is attacking!");

else

AssignCommand(GetFirstPC(), JumpToObject(GetObjectByTag("ShieldTradingCompany_To_Voonlar")));
}

