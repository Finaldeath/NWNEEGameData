void main()
{
if (GetLocalInt(GetFirstPC(), "nobronfollow") == 1)

SpeakString("You cannot flee the area while the Bron is attacking!");

else

AssignCommand(GetFirstPC(), JumpToObject(GetObjectByTag("LashansHouse_To_Voonlar")));
}

