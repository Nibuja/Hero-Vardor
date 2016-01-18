--Hero: Vardor
--Ability: Piercing Shot
--Author: Nibuja
--Date: 29.12.2015

--[[ PiercingShotCast
Creates a tracking projectile, firing at a POINT or TARGET
]]
function PiercingShotCastHero(keys)

	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	enemies_found = nil
	target_bool = false
	local indicator = keys.Indicator
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")
	------------------------Important---------------------
	local yari_stack = caster:GetModifierStackCount("modifier_hold_yari", ability_partner)
	caster:SetModifierStackCount("modifier_hold_yari", ability_partner, yari_stack - 1)
	SubAbility(caster, ability)	
	------------------------------------------------------
	target = keys.target
	local target_point = target:GetAbsOrigin()


	local lance_speed = ability:GetLevelSpecialValueFor("projectile_speed", ability_level)
	local vision_radius = ability:GetLevelSpecialValueFor("vision_radius", ability_level)
	local area_of_effect = ability:GetLevelSpecialValueFor("AOE", ability_level)
	local arrow_width = ability:GetLevelSpecialValueFor("radius", ability_level)
	local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local direction = (target_point - caster_location):Normalized()
	local distance = caster_location - target_point
	local duration = ability:GetLevelSpecialValueFor("duration_spear", ability_level)
	local modifierName2 = "modifier_thinker"
	local lance_projectile2 = keys.lance_projectile_tracking


	local dmg_Table = {
						attacker = caster,
						damage = damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
						}
	local projectileTable = {
				Source = caster,
				Target = target,
				Ability = ability,	
				EffectName = lance_projectile2,
        		iMoveSpeed = lance_speed * 2,
				vSourceLoc= caster_location,                -- Optional (HOW)
				bDrawsOnMinimap = false,                          -- Optional
        		bDodgeable = false,                                -- Optional
        		bIsAttack = false,                                -- Optional
        		bVisibleToEnemies = true,                         -- Optional
        		bReplaceExisting = false,                         -- Optional
				bProvidesVision = true,                           -- Optional
				iVisionRadius = 400,                              -- Optional
				iVisionTeamNumber = caster:GetTeamNumber()        -- Optional
			}
			
	ProjectileManager:CreateTrackingProjectile(projectileTable)
	ability:ApplyDataDrivenModifier(caster, target, "modifier_stuck", {Duration = duration})
	dmg_Table.victim = target
	ApplyDamage(dmg_Table)
	ability:ApplyDataDrivenModifier(caster, caster, modifierName2, {Duration = duration})

	

	target_bool = true

end

function PiercingShotCastPoint(keys)

	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	enemies_found = nil
	local indicator = keys.Indicator
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")	
	------------------------Important---------------------
	local yari_stack = caster:GetModifierStackCount("modifier_hold_yari", ability_partner)
	--caster:SetModifierStackCount("modifier_hold_yari", ability_partner, yari_stack - 1)
	--SubAbility(caster, ability)	
	------------------------------------------------------

	target_point = keys.target_points[1]


	local target_teams = ability:GetAbilityTargetTeam()
	local target_types = ability:GetAbilityTargetType()
	local target_flags = ability:GetAbilityTargetFlags()
	local modifierName1 = "modifier_prevent_movement"
	local lance_projectile = keys.lance_projectile
	

	local lance_speed = ability:GetLevelSpecialValueFor("projectile_speed", ability_level) * 2
	local vision_radius = ability:GetLevelSpecialValueFor("vision_radius", ability_level)
	local area_of_effect = ability:GetLevelSpecialValueFor("AOE", ability_level)
	local arrow_width = ability:GetLevelSpecialValueFor("radius", ability_level)
	local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local direction = (target_point - caster_location):Normalized()
	local distance = caster_location - target_point
	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)

	local projectileTable = 
	{
		EffectName = lance_projectile,
   	    Ability = ability,
       	vSpawnOrigin = caster_location,
       	vVelocity = direction * lance_speed,
   	    fDistance = (caster_location - target_point):Length(), 
   	    fStartRadius = arrow_width,
   	    fEndRadius = arrow_width,
   		Source = caster,
   	    bHasFrontalCone = false,
   	    bReplaceExisting = false,
   	    iUnitTargetTeam = ability:GetAbilityTargetTeam(),
   	    iUnitTargetFlags = ability:GetAbilityTargetFlags(),
   	    iUnitTargetType = ability:GetAbilityTargetType(),
       	bProvidesVision = true,
   	    iVisionRadius = vision_radius,
       	iVisionTeamNumber = caster:GetTeamNumber()
	}
	


	if target_bool == false then
		ProjectileManager:CreateLinearProjectile(projectileTable)
		enemies_found = FindUnitsInRadius(caster:GetTeamNumber(), target_point, nil, area_of_effect, target_teams, target_types, target_flags, FIND_CLOSEST, false) 
	

	caster:SetModifierStackCount("modifier_hold_yari", ability_partner, yari_stack - 1)

	local yari_stack = caster:GetModifierStackCount("modifier_hold_yari", ability_partner)

	end
	
	target_bool = false
end

function LanceHit(keys)
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	local target_teams = ability:GetAbilityTargetTeam()
	local target_types = ability:GetAbilityTargetType()
	local target_flags = ability:GetAbilityTargetFlags()

	local modifierName1 = "modifier_prevent_movement"

	local lance_projectile = keys.lance_projectile
	local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local lance_speed = ability:GetLevelSpecialValueFor("projectile_speed", ability_level)
	local vision_radius = ability:GetLevelSpecialValueFor("vision_radius", ability_level)
	local area_of_effect = ability:GetLevelSpecialValueFor("AOE", ability_level)
	local arrow_width = ability:GetLevelSpecialValueFor("radius", ability_level)
	local duration_spear = ability:GetLevelSpecialValueFor("duration_spear", ability_level)
	local direction = (target_point - caster_location):Normalized()
	local distance = caster_location - target_point
	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)

	local damage_table = {}
		damage_table.attacker = caster
		damage_table.ability = ability
		damage_table.damage_type = ability:GetAbilityDamageType() 
		damage_table.damage = damage 




	for _,hero in pairs(enemies_found) do
		damage_table.victim = hero
		ApplyDamage(damage_table)
		ability:ApplyDataDrivenModifier(caster, hero, modifierName1, {Duration = duration})
	end  




	dummy = CreateUnitByName("dummy_unit" , target_point, false, caster, caster, caster:GetTeamNumber())
	ability:ApplyDataDrivenModifier(caster, dummy, "modifier_dummy_health", nil)
	ability:ApplyDataDrivenModifier(caster, dummy, "modifier_dummy_slow_aura", nil)
	ability:ApplyDataDrivenModifier(caster, dummy, "modifier_kill", {Duration = duration_spear})


	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lina/lina_spell_light_strike_array_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, dummy)
end

function SubAbility(caster, ability)
	local sub_ability_name = "vardor_return_of_the_yari"
	local main_ability_name = ability:GetAbilityName()
	local sub_ability_name_2 = "vardor_graceful_jump"
	local sub_ability_name_3 = "vardor_graceful_jump_weak"


	caster:SwapAbilities(sub_ability_name, main_ability_name , true, false)
	caster:SwapAbilities(sub_ability_name_2, sub_ability_name_3, true, false)
end

function SubAbilityEnd(keys)
	local caster = keys.caster
	local ability = keys.ability
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")	
	local modifierName2 = "modifier_thinker"

	-----Increasing Yari stack by 1-----
	caster:SetModifierStackCount("modifier_hold_yari", ability, 1)
	------------------------------------

	-----Kill dummy-----
	local dummy_search = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER,false)
	for _,unit in pairs(dummy_search) do
		if unit:HasModifier("modifier_dummy_health") then
			unit:ForceKill(false)
		end
	end
	--------------------

	-----Swap Abilities back-----
	local sub_ability_name = "vardor_return_of_the_yari"
	local main_ability_name = "vardor_piercing_shot"
	local sub_ability_name_2 = "vardor_graceful_jump"
	local sub_ability_name_3 = "vardor_graceful_jump_weak"
	caster:SwapAbilities(main_ability_name, sub_ability_name, true, false)
	caster:SwapAbilities(sub_ability_name_3, sub_ability_name_2, true, false)
	----------------------------
end

function SwapBack(keys)
	local caster = keys.caster
	local modifier = "modifier_yari"

	-----Remove old modifier-----
	caster:RemoveModifierByName(modifier)
	-----------------------------
end



function OnUpgrade(keys)
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = keys.ability:GetLevel()
	local sub_ability_name = "vardor_return_of_the_yari"
	local ability_handle = caster:FindAbilityByName(sub_ability_name)
	local sub_ability_level = ability_handle:GetLevel()
	local modifier_1 = "modifier_hold_yari"
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")

	if sub_ability_level ~= ability_level then
        ability_handle:SetLevel(ability_level)
    end

	if caster:HasModifier(modifier_1) then
	else
		ability_partner:ApplyDataDrivenModifier(caster, caster, modifier_1, {})
	end

	local current_stack = caster:GetModifierStackCount( modifier_1 , ability_partner )
	if current_stack == 0 then
		caster:SetModifierStackCount(modifier_1, ability_partner, 1)
	end 
end

--[[ TEST
function CDOTA_BaseNPC:FindModifierByName(vardor_mental_thrusts)
	modifier_1 = "modifier_mental_thrusts_target_datadriven"
	modifier_2 = "mental_thrusts_debuff"


end
]]

function ApplyMentalThrusts(keys)
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = keys.ability:GetLevel()
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")
	local ability_partner_level = ability_partner:GetLevel()
	--local modifier_1 = caster:FindModifierByName("modifier_mental_thrusts_target_datadriven")
	--local modifier_2 = caster:FindModifierByName("mental_thrusts_debuff")
	local modifier_1 = "modifier_mental_thrusts_target_datadriven"
	local modifier_2 = "mental_thrusts_debuff"
	local modifier_3 = "modifier_stuck"
	local duration_spear = ability:GetLevelSpecialValueFor("duration_spear", ability_level)
	if not target:IsAlive() then
		return
	end

	if ability_partner_level > 0 and target:IsAlive() then
	ability_partner:ApplyDataDrivenModifier(caster, target, modifier_1, {Duration=duration_spear})
	ability_partner:ApplyDataDrivenModifier(caster, target, modifier_2, {Duration=duration_spear})
	local current_stack = target:GetModifierStackCount( modifier_1 , ability_partner )
	if current_stack < 0 and target:IsAlive() then
	target:SetModifierStackCount(modifier_1, ability_partner, 1)
	target:SetModifierStackCount(modifier_2, ability_partner, 1)
	end

end
end

function IncreaseMentalThrusts(keys)
	
	local caster = keys.caster

	local modifier_1 = "modifier_mental_thrusts_target_datadriven"
	local modifier_2 = "mental_thrusts_debuff"
	local ability_partner = caster:FindAbilityByName("vardor_mental_thrusts")
	local ability_partner_level = ability_partner:GetLevel()

	--[[
	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER,false)
	for _,hero in pairs(enemies) do
		if hero:HasModifier(modifier_1) then
			target = hero
			bool_1 = true
		end
	end
	]]--


	if ability_partner_level > 0 then
	local current_stack = target:GetModifierStackCount(modifier_1, ability_partner)
	if target:IsAlive() then
		if current_stack > 0 then
			ability_partner:ApplyDataDrivenModifier( caster, target, modifier_1, {})
			ability_partner:ApplyDataDrivenModifier( caster, target, modifier_2, {})
			target:SetModifierStackCount( modifier_1, ability_partner , current_stack + 1)
			target:SetModifierStackCount( modifier_2, ability_partner , current_stack + 1)
		else
			ability_partner:ApplyDataDrivenModifier( caster, target, modifier_1, {})
			ability_partner:ApplyDataDrivenModifier( caster, target, modifier_2, {})
			target:SetModifierStackCount( modifier_1, ability_partner, 1)
			target:SetModifierStackCount( modifier_2, ability_partner, 1)
		end
	end
	end

			
	
end

