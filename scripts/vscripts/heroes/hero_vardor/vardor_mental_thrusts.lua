--Hero: Vardor
--Ability: Mental Thrusts
--Author: Nibuja
--Date: 17.11.2015 
-- NO MORE STACKINH WJILE ATTACKING

--[[ MentalThrustsHit:
Increases the Stack counter each time of landed Attack
]]
function MentalThrustsHit(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier_1 = "mental_thrusts_debuff" 
	local modifier_2 = "modifier_mental_thrusts_target_datadriven"
	local ability_level = ability:GetLevel() - 1
	local yari_stack = caster:GetModifierStackCount("modifier_hold_yari", ability)
	local ability_partner = caster:FindAbilityByName("vardor_celestial_yari")

	--[[
	if yari_stack > 0 and caster:HasModifier("modifier_celestial") and target:IsHero() then

	if target:HasModifier( modifierName2 ) then
		local current_stack = target:GetModifierStackCount( modifierName2 , ability )

		ability:ApplyDataDrivenModifier( caster, target, modifierName2, {})
		ability:ApplyDataDrivenModifier( caster, target, modifierName1, {})
		target:SetModifierStackCount( modifierName2, ability, current_stack + yari_stack)
		target:SetModifierStackCount( modifierName1, ability, current_stack + yari_stack)
	else
		ability:ApplyDataDrivenModifier( caster, target, modifierName2, {} )
		ability:ApplyDataDrivenModifier( caster, target, modifierName1, {} )
		target:SetModifierStackCount( modifierName2, ability, 1 )
		target:SetModifierStackCount( modifierName1, ability, 1 )
	end
	--]]
	local mana = target:GetMana()
	if target:IsHero and target:IsAlive and mana > 20 and not caster:IsIllusion() then
	local current_stack = target:GetModifierStackCount( modifier_2 , ability )
	if current_stack > 0 and yari_stack > 0 then
		ability:ApplyDataDrivenModifier( caster, target, modifier_1, {})
		ability:ApplyDataDrivenModifier( caster, target, modifier_2, {})
		target:SetModifierStackCount( modifier_1, ability , current_stack + 1)
		target:SetModifierStackCount( modifier_2, ability , current_stack + 1)
	elseif yari_stack > 0 then
		ability:ApplyDataDrivenModifier( caster, target, modifier_1, {})
		ability:ApplyDataDrivenModifier( caster, target, modifier_2, {})
		target:SetModifierStackCount( modifier_1, ability, 1)
		target:SetModifierStackCount( modifier_2, ability, 1)
	else
		return
	end
	end
end



	
end

function OnUpgrade(keys)

	local caster = keys.caster
	local ability = keys.ability
	local modifier_1 = "modifier_hold_yari"
	ability:ApplyDataDrivenModifier(caster, caster, modifier_1, {})
	local current_stack = caster:GetModifierStackCount( modifier_1 , ability )
	if current_stack == 0 then
		caster:SetModifierStackCount(modifier_1, ability, 1)
	end 

end