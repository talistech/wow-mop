/*
* This file is part of the Pandaria 5.4.8 Project. See THANKS file for Copyright information
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include "GameObject.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "AreaTrigger.h"
//#include "AreaTriggerAI.h"
#include "LFGMgr.h"
//#include "SceneHelper.h"

enum WatersOfFarseeing
{
    QUEST_THE_EYE_OF_THE_STORM_HORDE    = 28805,
    QUEST_THE_EYE_OF_THE_STORM_ALLIANCE = 28826,
    NPC_WATERS_OF_FARSEEING_CREDIT      = 50054,
    WATERS_OF_FARSEEING_DURATION        = 5 * IN_MILLISECONDS
};

class spell_waters_of_farseeing_94687 : public SpellScriptLoader
{
public:
    spell_waters_of_farseeing_94687() : SpellScriptLoader("spell_waters_of_farseeing_94687") { }

    class spell_waters_of_farseeing_94687_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_waters_of_farseeing_94687_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Player* player = GetTarget()->ToPlayer())
                if (player->GetQuestStatus(QUEST_THE_EYE_OF_THE_STORM_HORDE) == QUEST_STATUS_INCOMPLETE ||
                    player->GetQuestStatus(QUEST_THE_EYE_OF_THE_STORM_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(NPC_WATERS_OF_FARSEEING_CREDIT);

            GetAura()->SetMaxDuration(WATERS_OF_FARSEEING_DURATION);
            GetAura()->SetDuration(WATERS_OF_FARSEEING_DURATION);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_waters_of_farseeing_94687_AuraScript::OnApply, EFFECT_0, SPELL_AURA_SCREEN_EFFECT, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_waters_of_farseeing_94687_AuraScript();
    }
};

void AddSC_orgrimmar()
{
    new spell_waters_of_farseeing_94687();
}
