void main()
{
        object oArea = GetArea(OBJECT_SELF);
        object oWitch = GetLocalObject(oArea, "BattleWL");
        if (GetIsObjectValid(oWitch) && GetArea(oWitch) == oArea)
        {
           int nSpell;
           switch(Random(1))
           {
              case 0: ActionCastFakeSpellAtObject(SPELL_FEEBLEMIND,oWitch); break;
              case 1: ActionCastFakeSpellAtObject(SPELL_MONSTROUS_REGENERATION,OBJECT_SELF);
           }
           DelayCommand(7.1,SetCommandable(TRUE));
           SetCommandable(FALSE);
           SetLocalInt(OBJECT_SELF, "WLPresent",1);
        }
        else
        {
           if (GetLocalInt(OBJECT_SELF, "WLPresent"))
           {
              string sSpeak;
              if (GetIsInCombat())
                  sSpeak = "Go get the Witch Lord, I'll stay here and keep them busy!";
              else
                  sSpeak = "Hurry, follow the Witch Lord, I'll take care of our men!";
              ActionSpeakString(sSpeak);
            }
        }
}
