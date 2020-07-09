//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_grayrend0
//:: DATE: March 06, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: The Gray Render in Comanthor will go hostile if
//:: the player comes too close to his Stag
//::////////////////////////////////////////////////////


const float HOSTILE_DELAY = 2.0f;
const float HOSTILE_DISTANCE = 4.0f;


void GoHostileIfClose(object oPC, object oProtector, object oProtectee)
{
    if (GetDistanceBetween(oPC, oProtectee) <= HOSTILE_DISTANCE)
    {
        ExecuteScript("hf_ut_hostile", oProtector);
    }
}


void main()
{
    string sRenderTag = GetLocalString(OBJECT_SELF, "protector");
    string sStagTag = GetLocalString(OBJECT_SELF, "protectee");
    string sMessage = GetLocalString(OBJECT_SELF, "message");

    object oPC = GetEnteringObject();
    object oProtector = GetNearestObjectByTag(sRenderTag, oPC);
    object oProtectee = GetNearestObjectByTag(sStagTag, oPC);

    if ( GetIsPC(oPC) &&
         GetIsObjectValid(oProtector) && !GetIsDead(oProtector) &&
         GetIsObjectValid(oProtectee) )
    {
        int nLock = GetLocalInt(OBJECT_SELF, "lock");
        if (nLock <= 0)
        {
            SetLocalInt(OBJECT_SELF, "lock", 1);

            AssignCommand(oPC, SpeakString(sMessage));

            DelayCommand(HOSTILE_DELAY, GoHostileIfClose(oPC, oProtector, oProtectee));
            DelayCommand(HOSTILE_DELAY, DeleteLocalInt(OBJECT_SELF, "lock"));
        }
    }
}
