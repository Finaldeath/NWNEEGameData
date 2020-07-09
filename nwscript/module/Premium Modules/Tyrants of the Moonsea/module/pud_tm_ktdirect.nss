//Handle actions resulting from the destruction of Kur-Tharsu Main Gate

#include "nw_i0_generic"

#include "hf_in_plot"
#include "inc_ktgate"

void RemoveCutsceneEffects(object oCompanion)
{
    effect eEff = GetFirstEffect(oCompanion);
    while (GetIsEffectValid(eEff))
    {
        if (GetEffectCreator(eEff) == OBJECT_SELF)
        {
            RemoveEffect(oCompanion, eEff);
        }
        eEff = GetNextEffect(oCompanion);
    }
}

void main()
{
    object oBlizzard;
    object oElf;

    object oBlock;
    object oGate;

    vector vGate;

    location lGateLoc;
    location lBlock;

    effect eExplosion;
    effect eInvis;
    effect eLargeStones;
    effect eParalyze;
    effect eSmallStones;
    effect eShake;

    switch(GetUserDefinedEventNumber())
    {
        case 4500 :
        //Prevent further missile or oil attacks
        DestroyObject(GetObjectByTag("TriggerOil1"));
        DestroyObject(GetObjectByTag("TriggerOil2"));

        PlotLevelSet("KTBridgeMissile", 0);
        PlotLevelSet("KTCourtyardMissile", 0);
        PlotLevelSet("KTGateDestroyed", 1);

        //Destroy Gate
        oBlock = GetNearestObjectByTag("KTStoneBlock");
        oGate = GetNearestObjectByTag("KTPortcullis");

        //We want to apply destroy effects to middle of gate
        vGate = GetPosition(oGate);
        vGate.z +=2.0;
        lGateLoc = Location(GetArea(oGate), vGate, 90.0);
        lBlock = GetLocation(oBlock);

        eExplosion = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        eLargeStones = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM );
        eSmallStones = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
        eShake = EffectVisualEffect(356);;

        MusicBattleStop(GetArea(OBJECT_SELF));

        //Sound of structure crumbling
        SoundObjectPlay(GetNearestObjectByTag("GateDestroyed"));
        DelayCommand(10.0, SoundObjectStop(GetNearestObjectByTag("GateDestroyed")));

        //Destruction effects
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplosion, lGateLoc);
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, GetFirstPC(), 4.0));
        DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmallStones, lBlock));
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLargeStones, lBlock));
        DestroyObject(oGate, 2.0);

        //If Wrecker at gate, or ordered to destroy gate, set Wrecker ready to go home
        if(PlotLevelGet("TheWrecker") == 1 || PlotLevelGet("TheWrecker") == 2)
        {
            PlotLevelSet("TheWrecker", 3);
        }

        //Set Blizzard and Elf to indicate gate is destroyed if with PC
        if(PlotLevelGet("Blizzard") >= 10 && PlotLevelGet("Blizzard") < 14)
        {
            PlotLevelSet("Blizzard", 14);
            oBlizzard = GetLocalObject(OBJECT_SELF, "oBlizzard");
            SetPlotFlag(oBlizzard, FALSE);
        }

        if(PlotLevelGet("Elf") >= 15 && PlotLevelGet("Elf") < 18)
        {
            PlotLevelSet("Elf", 18);
        }

        break;

        case 4501:
        //Cutscene freeze Blizzard and Elf if present
        oBlizzard = GetLocalObject(OBJECT_SELF, "oBlizzard");
        oElf = GetLocalObject(OBJECT_SELF, "oElf");
        eParalyze = EffectCutsceneParalyze();
        eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

        if(GetIsObjectValid(oBlizzard))
        {
            SetLocalInt(oBlizzard, "nCutsceneMode", 1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oBlizzard);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oBlizzard);
        }

        if(GetIsObjectValid(oElf))
        {
            SetLocalInt(oElf, "nCutsceneMode", 1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oElf);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElf);
        }

        break;
        case 4502:
        //Cutscene remove effects from Blizzard and Elf if present
        oBlizzard = GetLocalObject(OBJECT_SELF, "oBlizzard");
        oElf = GetLocalObject(OBJECT_SELF, "oElf");
        if(GetIsObjectValid(oBlizzard))
        {
            RemoveCutsceneEffects(oBlizzard);
            AssignCommand(oBlizzard,
                JumpToLocation(GetLocation(GetWaypointByTag("WP_KurtharsuCrtyrd_Gate"))));
            SetLocalInt(oBlizzard, "nCutsceneMode", 0);
        }

        if(GetIsObjectValid(oElf))
        {
            RemoveCutsceneEffects(oElf);
            AssignCommand(oElf,
                JumpToLocation(GetLocation(GetWaypointByTag("WP_KurtharsuCrtyrd_Gate"))));
            SetLocalInt(oElf, "nCutsceneMode", 0);
        }
        break;
    }
}
