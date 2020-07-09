/*
    DLA_MELREMVAR.nss
    gaoneng erick            June 24, 2006

    deletes the GN_JUST_FINISH_BOUT variable from the player.
*/

#include "dla_mel_inc2"

void main()
{
    DeleteLocalInt(GetPCSpeaker(), DLA_JUST_FINISH_BOUT);
}

/*
#include "dla_mel_inc"
void main()
{
      DeleteLocalInt(GetPCSpeaker(), nMeleeJustFinish); //Don't remove until after prize given
}
