//Test Shop: Markup = 0, Markdown = 0;
#include "nw_i0_plot"
void main()
{
    int iMarkup = 0;
    int iMarkdown = 0;
    object oStore = GetObjectByTag("TestStore");
    object oPC = GetPCSpeaker();

    gplotAppraiseOpenStore(oStore, oPC, iMarkup, iMarkdown);
}
