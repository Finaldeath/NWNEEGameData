#include "nw_i0_generic"

void main()
{
    string q = GetLocalString(GetModule(), "QUOTE");
    object oNPC;
    object oPC = GetFirstPC();

    switch(GetUserDefinedEventNumber())
    {
        //Munroes flee if Jethroe dies or flees
        case 5400:
            oNPC = GetNearestObjectByTag("db_fang", oPC);
            AssignCommand(oNPC,ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE));
            AssignCommand(oNPC, ActionDoCommand(DestroyObject(OBJECT_SELF)));
            AssignCommand(oNPC, SetCommandable(FALSE, oNPC));
            oNPC = GetNearestObjectByTag("db_sossimunroe", oPC);
            AssignCommand(oNPC,ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE));
            AssignCommand(oNPC, ActionDoCommand(DestroyObject(OBJECT_SELF)));
            AssignCommand(oNPC, SetCommandable(FALSE, oNPC));
            oNPC = GetNearestObjectByTag("db_methromunroe", oPC);
            AssignCommand(oNPC,ClearAllActions(TRUE));
            if(!GetIsDead(oNPC))
            {
                AssignCommand(oNPC, SpeakString(q+"Run!"+q));
                AssignCommand(oNPC, ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE));
                AssignCommand(oNPC, ActionDoCommand(DestroyObject(OBJECT_SELF)));
                AssignCommand(oNPC, SetCommandable(FALSE, oNPC));
            }
            oNPC = GetNearestObjectByTag("db_yagemunroe", oPC);
            AssignCommand(oNPC,ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE));
            AssignCommand(oNPC, ActionDoCommand(DestroyObject(OBJECT_SELF)));
            AssignCommand(oNPC, SetCommandable(FALSE, oNPC));
        break;

        //Munroes turn hostile and attack
        case 5401:
            object oJethro=GetNearestObjectByTag("db_jethromunroe");
            object oMethro=GetNearestObjectByTag("db_methromunroe");
            object oYage=GetNearestObjectByTag("db_yagemunroe");
            object oSossi=GetNearestObjectByTag("db_sossimunroe");
            object oFang=GetNearestObjectByTag("db_fang");

            SetLocalInt(GetModule(),"render",2);

            DelayCommand(0.2,ChangeToStandardFaction(oJethro,STANDARD_FACTION_HOSTILE));
            DelayCommand(0.2,ChangeToStandardFaction(oMethro,STANDARD_FACTION_HOSTILE));
            DelayCommand(0.2,ChangeToStandardFaction(oYage,STANDARD_FACTION_HOSTILE));
            DelayCommand(0.2,ChangeToStandardFaction(oSossi,STANDARD_FACTION_HOSTILE));
            DelayCommand(0.2,ChangeToStandardFaction(oFang,STANDARD_FACTION_HOSTILE));
            DelayCommand(0.5,AssignCommand(oJethro,DetermineCombatRound(oPC)));
            DelayCommand(0.5,AssignCommand(oMethro,DetermineCombatRound(oPC)));
            DelayCommand(0.5,AssignCommand(oYage,DetermineCombatRound(oPC)));
            DelayCommand(0.5,AssignCommand(oSossi,DetermineCombatRound(oPC)));
            DelayCommand(0.5,AssignCommand(oFang,DetermineCombatRound(oPC)));
        break;
    }
}
